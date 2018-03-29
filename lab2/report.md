# 操作系统——实验二
-------------------------------------------------------
###练习零
------------------------------------------------------------------
>本实验依赖实验1。请把你做的实验1的代码填入本实验中代码中有“LAB1”的注释相应部分。提示：可采用diff和patch工具进行半自动的合并（merge），也可用一些图形化的比较/merge工具来手动合并，比如meld，eclipse中的diff/merge工具，understand中的diff/merge工具等。


完成了将实验一的内容转向实验二的过程，期间使用了meld工具通过可视化见面完成

###练习一
---------------------------------------------------------
>实现 first-fit 连续物理内存分配算法（需要编程）
>在实现first fit 内存分配算法的回收函数时，要考虑地址连续的空闲块之间的合并操作。提示:在建立空闲页块链表时，需要按照空闲页块起始地址来排序，形成一个有序的链表。可能会修改default_pmm.c中的default_init，default_init_memmap，default_alloc_pages， default_free_pages等相关函数。请仔细查看和理解default_pmm.c中的注释。

实现 first-fit 连续物理内存分配方法是一个比较简单的物理内存分配方法，其中default_init，default_init_memmap两个函数lab2中给出的代码已经比较完整，不需要修改，只需要修改default_alloc_pages， default_free_pages两个函数就可以了。其中default_alloc_pages 作用是寻找空闲块列表中第一个能够满足请求的块即停止搜索，然后把搜索到的块分割，一部分返回给请求者，另一部分仍然作为空闲块留在空闲列表的原来位置。
具体代码的实现如下：
```cpp
default_alloc_pages(size_t n) {
    assert(n > 0);
    if (n > nr_free) {
        return NULL;
    }
    list_entry_t *le, *len;
    le = &free_list;
    while((le=list_next(le)) != &free_list) {
      struct Page *p = le2page(le, page_link);
      if(p->property >= n){
        int i;
        for(i=0;i<n;i++){
          len = list_next(le);
          struct Page *pp = le2page(le, page_link);
          SetPageReserved(pp);
          ClearPageProperty(pp);
          list_del(le);
          le = len;
        }
        if(p->property>n){
          (le2page(le,page_link))->property = p->property - n;
        }
        ClearPageProperty(p);
        SetPageReserved(p);
        nr_free -= n;
        return p;
      }
    }
    return NULL;
}
```
其中 while((le=list_next(le)) != &free_list) 的作用是遍历空闲块列表当找到第一个大小大于等于n的空闲块时将之取出。同时用将该块从空闲块列表中去除。最后将表le删去，令其等于len（为list_next(le))。
之后如果这个块大于n则要将这个块分为两个块，其中一个大小减去n之后返回，大小为n的块取出使用。
如果经过一次循环之后没有找到这样的块则返回NULL。

```cpp
static void default_free_pages(struct Page *base, size_t n) {
    assert(n > 0);
    assert(PageReserved(base));
    list_entry_t *le = &free_list;
    struct Page * p;
    while((le=list_next(le)) != &free_list) {
      p = le2page(le, page_link);
      if(p>base){
        break;
      }
    }
    for(p=base;p<base+n;p++){
      list_add_before(le, &(p->page_link));
    }
    base->flags = 0;
    set_page_ref(base, 0);
    ClearPageProperty(base);
    SetPageProperty(base);
    base->property = n;
    
    p = le2page(le,page_link) ;
    if( base+n == p ){
      base->property += p->property;
      p->property = 0;
    }
    le = list_prev(&(base->page_link));
    p = le2page(le, page_link);
    if(le!=&free_list && p==base-1){
      while(le!=&free_list){
        if(p->property){
          p->property += base->property;
          base->property = 0;
          break;
        }
        le = list_prev(le);
        p = le2page(le,page_link);
      }
    }
    nr_free += n;
    return ;
}
```
这段代码主要完成了将空闲页重新放回到空闲列表块中，其中在循环while((le=list_next(le)) != &free_list)中找到基址base在空闲列表块中对应的位置。之后将之加入到空闲列表块中。最后对列表中总共的空闲块进行更新，即nr_free += n。

>问题：你的first fit算法是否有进一步的改进空间
>回答：我认为空闲空间块列表如果使用块状列表的话可以极大的提高效率。可以将空间复杂度从O(n)变为O(sqrt(n))。具体实现方法为每个Node上存放一个数组，按照块的大小排序，每次寻找时通过块状链表查找复杂度将大幅降低。

###练习二
-----------------------------------------------------
>实现寻找虚拟地址对应的页表项（需要编程）
>通过设置页表和对应的页表项，可建立虚拟内存地址和物理内存地址的对应关系。其中的get_pte函数是设置页表项环节中的一个重要步骤。此函数找到一个虚地址对应的二级页表项的内核虚地址，如果此二级页表项不存在，则分配一个包含此项的二级页表。本练习需要补全get_pte函数 in kern/mm/pmm.c，实现其功能。

具体代码如下：
```cpp
get_pte(pde_t *pgdir, uintptr_t la, bool create) {
    pde_t *pdep = &pgdir[PDX(la)];
    if (!(*pdep & PTE_P)) {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL) {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
        *pdep = pa | PTE_U | PTE_W | PTE_P;
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep)))[PTX(la)];
}
```
首先试图找到一个虚地址对应的二级页表项的内核虚地址，具体代码为
>pde_t *pdep = &pgdir[PDX(la)]

之后如果改地址不存在就判断是否需要建立一个新的页表
>if (!create || (page = alloc_page()) == NULL) {
            return NULL;
        }

然后分配一个二级页表
>set_page_ref(page, 1);
> uintptr_t pa = page2pa(page);
> memset(KADDR(pa), 0, PGSIZE);
> *pdep = pa | PTE_U | PTE_W | PTE_P;

返回该二级页表
>return &((pte_t *)KADDR(PDE_ADDR(*pdep)))[PTX(la)];

####问题

>请描述页目录项（Pag Director Entry）和页表（Page Table Entry）中每个组成部分的含义和以及对 ucore 而言的潜在用处。

   答： 从 `kern/mm/mmu.h` 中定义的宏可知，页目录表项和页表项的组成如下：

    ```
    31                                    12 11    8       4       0
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |                                       |     |   | | |P|P|U|R| |
    |    Address of page table/page frame   |AVAIL|0 0|D|A|C|W|/|/|P|
    |                                       |     |   | | |D|T|S|W| |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    ```

 各字段的含义如下：
    + `Address`：页表/页帧物理地址的前 20 位。
    + `P`：Present，ucore 中用于表示物理内存页是否存在；
    + `R/W`：Read/write，ucore 中用于表示物理内存页内容是否可写；
    + `U/S`：User/supervisor，ucore 中用于表示用户态的软件是否可以读取对应地址的物理内存页内容。
    + `PWT`：Page-level write-through，ucore 中未使用；
    + `PCD`：Page-level cache-disable，ucore 中未使用；
    + `A`：Accessed，ucore 中未使用；
    + `D`：Dirty，ucore 中未使用；
    + `AVAIL`：可被系统程序员使用，ucore 中未使用。

>如果 ucore 执行过程中访问内存，出现了页访问异常，请问硬件要做哪些事情？
>答：保存现场状态，触发 Page Fault 异常，转入中断处理程序，然后交给软件处理，软件会从磁盘中读入一个页面到内存。

###练习三
-------------------------------------------
>释放某虚地址所在的页并取消对应二级页表项的映射（需要编程）
>当释放一个包含某虚地址的物理内存页时，需要让对应此物理内存页的管理数据结构Page做相关的清除处理，使得此物理内存页成为空闲；另外还需把表示虚地址与物理地址对应关系的二级页表项清除。

具体代码如下：
```cpp
page_remove_pte(pde_t *pgdir, uintptr_t la, pte_t *ptep) {
    if (*ptep & PTE_P) {
        struct Page *page = pte2page(*ptep);
        if (page_ref_dec(page) == 0) {
            free_page(page);
        }
        *ptep = 0;
        tlb_invalidate(pgdir, la);
    }
}
```
首先确认页目录是否存在if (*ptep & PTE_P)，之后通过free_page来清除页表，最后用tlb_invalidate(pgdir, la)释放页表映射。

>问题：数据结构 Page 的全局变量（其实是一个数组）的每一项与页表中的页目录项和页表项有无对应关系？如果有，其对应关系是啥？
>答：`pages` 数组存放 `Page` 结构，每一个元素对应一个物理页面，其下标的含义是该物理页面在所有页面中的编号，等于页起始物理地址的前 20 位。通过 `page2pa()` 函数可获取一个 `Page` 结构对应的页面的起始物理地址(下标左移 12 位)，函数 `pa2page()` 可获取一个物理地址对应的 `Page` 结构(地址右移 12 位得下标)。而一个页目录项/页表项的的前 20 位表示页表/页帧物理地址的前 20 位，或是它们所在页的起始地址的前 20 位。通过调用 `pa2page()` 函数即能得到该页目录项/页表项对应的那个页的 `Page` 结构，这就是 `pde2page()`/`pte2page()` 的实现原理。

>问题： 如果希望虚拟地址与物理地址相等，则需要如何修改 lab2，完成此事？
>答：现有框架是段表不偏移，在页表中让线性地址和物理地址之间有 `0xC0000000` 的偏移，三者的关系为：
    virt addr = linear addr = phy addr + 0xC0000000
    实现虚拟地址与物理地址有两种方式：
    1. 不修改段表，修改页表里的映射关系，让线性地址和物理地址映射为相等，这样三者的关系为：      
        virt addr = linear addr = phy addr
    2. 修改段表的映射关系，让 `virt addr = linear addr - 0xC0000000`，不修改页表，这样三者的关系为：  
        virt addr = linear addr - 0xC0000000 = phy addr





        
        
      


