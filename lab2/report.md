# ����ϵͳ����ʵ���
-------------------------------------------------------
###��ϰ��
------------------------------------------------------------------
>��ʵ������ʵ��1�����������ʵ��1�Ĵ������뱾ʵ���д������С�LAB1����ע����Ӧ���֡���ʾ���ɲ���diff��patch���߽��а��Զ��ĺϲ���merge����Ҳ����һЩͼ�λ��ıȽ�/merge�������ֶ��ϲ�������meld��eclipse�е�diff/merge���ߣ�understand�е�diff/merge���ߵȡ�


����˽�ʵ��һ������ת��ʵ����Ĺ��̣��ڼ�ʹ����meld����ͨ�����ӻ��������

###��ϰһ
---------------------------------------------------------
>ʵ�� first-fit ���������ڴ�����㷨����Ҫ��̣�
>��ʵ��first fit �ڴ�����㷨�Ļ��պ���ʱ��Ҫ���ǵ�ַ�����Ŀ��п�֮��ĺϲ���������ʾ:�ڽ�������ҳ������ʱ����Ҫ���տ���ҳ����ʼ��ַ�������γ�һ��������������ܻ��޸�default_pmm.c�е�default_init��default_init_memmap��default_alloc_pages�� default_free_pages����غ���������ϸ�鿴�����default_pmm.c�е�ע�͡�

ʵ�� first-fit ���������ڴ���䷽����һ���Ƚϼ򵥵������ڴ���䷽��������default_init��default_init_memmap��������lab2�и����Ĵ����Ѿ��Ƚ�����������Ҫ�޸ģ�ֻ��Ҫ�޸�default_alloc_pages�� default_free_pages���������Ϳ����ˡ�����default_alloc_pages ������Ѱ�ҿ��п��б��е�һ���ܹ���������Ŀ鼴ֹͣ������Ȼ����������Ŀ�ָһ���ַ��ظ������ߣ���һ������Ȼ��Ϊ���п����ڿ����б��ԭ��λ�á�
��������ʵ�����£�
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
���� while((le=list_next(le)) != &free_list) �������Ǳ������п��б��ҵ���һ����С���ڵ���n�Ŀ��п�ʱ��֮ȡ����ͬʱ�ý��ÿ�ӿ��п��б���ȥ������󽫱�leɾȥ���������len��Ϊlist_next(le))��
֮�������������n��Ҫ��������Ϊ�����飬����һ����С��ȥn֮�󷵻أ���СΪn�Ŀ�ȡ��ʹ�á�
�������һ��ѭ��֮��û���ҵ������Ŀ��򷵻�NULL��

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
��δ�����Ҫ����˽�����ҳ���·Żص������б���У�������ѭ��while((le=list_next(le)) != &free_list)���ҵ���ַbase�ڿ����б���ж�Ӧ��λ�á�֮��֮���뵽�����б���С������б����ܹ��Ŀ��п���и��£���nr_free += n��

>���⣺���first fit�㷨�Ƿ��н�һ���ĸĽ��ռ�
>�ش�����Ϊ���пռ���б����ʹ�ÿ�״�б�Ļ����Լ�������Ч�ʡ����Խ��ռ临�Ӷȴ�O(n)��ΪO(sqrt(n))������ʵ�ַ���Ϊÿ��Node�ϴ��һ�����飬���տ�Ĵ�С����ÿ��Ѱ��ʱͨ����״������Ҹ��ӶȽ�������͡�

###��ϰ��
-----------------------------------------------------
>ʵ��Ѱ�������ַ��Ӧ��ҳ�����Ҫ��̣�
>ͨ������ҳ��Ͷ�Ӧ��ҳ����ɽ��������ڴ��ַ�������ڴ��ַ�Ķ�Ӧ��ϵ�����е�get_pte����������ҳ������е�һ����Ҫ���衣�˺����ҵ�һ�����ַ��Ӧ�Ķ���ҳ������ں����ַ������˶���ҳ������ڣ������һ����������Ķ���ҳ������ϰ��Ҫ��ȫget_pte���� in kern/mm/pmm.c��ʵ���书�ܡ�

����������£�
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
������ͼ�ҵ�һ�����ַ��Ӧ�Ķ���ҳ������ں����ַ���������Ϊ
>pde_t *pdep = &pgdir[PDX(la)]

֮������ĵ�ַ�����ھ��ж��Ƿ���Ҫ����һ���µ�ҳ��
>if (!create || (page = alloc_page()) == NULL) {
            return NULL;
        }

Ȼ�����һ������ҳ��
>set_page_ref(page, 1);
> uintptr_t pa = page2pa(page);
> memset(KADDR(pa), 0, PGSIZE);
> *pdep = pa | PTE_U | PTE_W | PTE_P;

���ظö���ҳ��
>return &((pte_t *)KADDR(PDE_ADDR(*pdep)))[PTX(la)];

####����

>������ҳĿ¼�Pag Director Entry����ҳ��Page Table Entry����ÿ����ɲ��ֵĺ�����Լ��� ucore ���Ե�Ǳ���ô���

   �� �� `kern/mm/mmu.h` �ж���ĺ��֪��ҳĿ¼�����ҳ�����������£�

    ```
    31                                    12 11    8       4       0
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |                                       |     |   | | |P|P|U|R| |
    |    Address of page table/page frame   |AVAIL|0 0|D|A|C|W|/|/|P|
    |                                       |     |   | | |D|T|S|W| |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    ```

 ���ֶεĺ������£�
    + `Address`��ҳ��/ҳ֡�����ַ��ǰ 20 λ��
    + `P`��Present��ucore �����ڱ�ʾ�����ڴ�ҳ�Ƿ���ڣ�
    + `R/W`��Read/write��ucore �����ڱ�ʾ�����ڴ�ҳ�����Ƿ��д��
    + `U/S`��User/supervisor��ucore �����ڱ�ʾ�û�̬������Ƿ���Զ�ȡ��Ӧ��ַ�������ڴ�ҳ���ݡ�
    + `PWT`��Page-level write-through��ucore ��δʹ�ã�
    + `PCD`��Page-level cache-disable��ucore ��δʹ�ã�
    + `A`��Accessed��ucore ��δʹ�ã�
    + `D`��Dirty��ucore ��δʹ�ã�
    + `AVAIL`���ɱ�ϵͳ����Աʹ�ã�ucore ��δʹ�á�

>��� ucore ִ�й����з����ڴ棬������ҳ�����쳣������Ӳ��Ҫ����Щ���飿
>�𣺱����ֳ�״̬������ Page Fault �쳣��ת���жϴ������Ȼ�󽻸�������������Ӵ����ж���һ��ҳ�浽�ڴ档

###��ϰ��
-------------------------------------------
>�ͷ�ĳ���ַ���ڵ�ҳ��ȡ����Ӧ����ҳ�����ӳ�䣨��Ҫ��̣�
>���ͷ�һ������ĳ���ַ�������ڴ�ҳʱ����Ҫ�ö�Ӧ�������ڴ�ҳ�Ĺ������ݽṹPage����ص��������ʹ�ô������ڴ�ҳ��Ϊ���У����⻹��ѱ�ʾ���ַ�������ַ��Ӧ��ϵ�Ķ���ҳ���������

����������£�
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
����ȷ��ҳĿ¼�Ƿ����if (*ptep & PTE_P)��֮��ͨ��free_page�����ҳ�������tlb_invalidate(pgdir, la)�ͷ�ҳ��ӳ�䡣

>���⣺���ݽṹ Page ��ȫ�ֱ�������ʵ��һ�����飩��ÿһ����ҳ���е�ҳĿ¼���ҳ�������޶�Ӧ��ϵ������У����Ӧ��ϵ��ɶ��
>��`pages` ������ `Page` �ṹ��ÿһ��Ԫ�ض�Ӧһ������ҳ�棬���±�ĺ����Ǹ�����ҳ��������ҳ���еı�ţ�����ҳ��ʼ�����ַ��ǰ 20 λ��ͨ�� `page2pa()` �����ɻ�ȡһ�� `Page` �ṹ��Ӧ��ҳ�����ʼ�����ַ(�±����� 12 λ)������ `pa2page()` �ɻ�ȡһ�������ַ��Ӧ�� `Page` �ṹ(��ַ���� 12 λ���±�)����һ��ҳĿ¼��/ҳ����ĵ�ǰ 20 λ��ʾҳ��/ҳ֡�����ַ��ǰ 20 λ��������������ҳ����ʼ��ַ��ǰ 20 λ��ͨ������ `pa2page()` �������ܵõ���ҳĿ¼��/ҳ�����Ӧ���Ǹ�ҳ�� `Page` �ṹ������� `pde2page()`/`pte2page()` ��ʵ��ԭ��

>���⣺ ���ϣ�������ַ�������ַ��ȣ�����Ҫ����޸� lab2����ɴ��£�
>�����п���Ƕα�ƫ�ƣ���ҳ���������Ե�ַ�������ַ֮���� `0xC0000000` ��ƫ�ƣ����ߵĹ�ϵΪ��
    virt addr = linear addr = phy addr + 0xC0000000
    ʵ�������ַ�������ַ�����ַ�ʽ��
    1. ���޸Ķα��޸�ҳ�����ӳ���ϵ�������Ե�ַ�������ַӳ��Ϊ��ȣ��������ߵĹ�ϵΪ��      
        virt addr = linear addr = phy addr
    2. �޸Ķα��ӳ���ϵ���� `virt addr = linear addr - 0xC0000000`�����޸�ҳ���������ߵĹ�ϵΪ��  
        virt addr = linear addr - 0xC0000000 = phy addr





        
        
      


