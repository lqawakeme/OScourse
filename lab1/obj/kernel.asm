
bin/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100006:	ba 20 fd 10 00       	mov    $0x10fd20,%edx
  10000b:	b8 16 ea 10 00       	mov    $0x10ea16,%eax
  100010:	29 c2                	sub    %eax,%edx
  100012:	89 d0                	mov    %edx,%eax
  100014:	89 44 24 08          	mov    %eax,0x8(%esp)
  100018:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001f:	00 
  100020:	c7 04 24 16 ea 10 00 	movl   $0x10ea16,(%esp)
  100027:	e8 c0 31 00 00       	call   1031ec <memset>

    cons_init();                // init the console
  10002c:	e8 7a 14 00 00       	call   1014ab <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 80 33 10 00 	movl   $0x103380,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 9c 33 10 00 	movl   $0x10339c,(%esp)
  100046:	e8 c7 02 00 00       	call   100312 <cprintf>

    print_kerninfo();
  10004b:	e8 f6 07 00 00       	call   100846 <print_kerninfo>

    grade_backtrace();
  100050:	e8 86 00 00 00       	call   1000db <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 d8 27 00 00       	call   102832 <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 8f 15 00 00       	call   1015ee <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 e1 16 00 00       	call   101745 <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 35 0c 00 00       	call   100c9e <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 ee 14 00 00       	call   10155c <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
  10006e:	eb fe                	jmp    10006e <kern_init+0x6e>

00100070 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100070:	55                   	push   %ebp
  100071:	89 e5                	mov    %esp,%ebp
  100073:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  100076:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10007d:	00 
  10007e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100085:	00 
  100086:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10008d:	e8 3e 0b 00 00       	call   100bd0 <mon_backtrace>
}
  100092:	c9                   	leave  
  100093:	c3                   	ret    

00100094 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100094:	55                   	push   %ebp
  100095:	89 e5                	mov    %esp,%ebp
  100097:	53                   	push   %ebx
  100098:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  10009b:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  10009e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1000a1:	8d 55 08             	lea    0x8(%ebp),%edx
  1000a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1000a7:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1000ab:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1000af:	89 54 24 04          	mov    %edx,0x4(%esp)
  1000b3:	89 04 24             	mov    %eax,(%esp)
  1000b6:	e8 b5 ff ff ff       	call   100070 <grade_backtrace2>
}
  1000bb:	83 c4 14             	add    $0x14,%esp
  1000be:	5b                   	pop    %ebx
  1000bf:	5d                   	pop    %ebp
  1000c0:	c3                   	ret    

001000c1 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000c1:	55                   	push   %ebp
  1000c2:	89 e5                	mov    %esp,%ebp
  1000c4:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000c7:	8b 45 10             	mov    0x10(%ebp),%eax
  1000ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1000d1:	89 04 24             	mov    %eax,(%esp)
  1000d4:	e8 bb ff ff ff       	call   100094 <grade_backtrace1>
}
  1000d9:	c9                   	leave  
  1000da:	c3                   	ret    

001000db <grade_backtrace>:

void
grade_backtrace(void) {
  1000db:	55                   	push   %ebp
  1000dc:	89 e5                	mov    %esp,%ebp
  1000de:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000e1:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000e6:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  1000ed:	ff 
  1000ee:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1000f9:	e8 c3 ff ff ff       	call   1000c1 <grade_backtrace0>
}
  1000fe:	c9                   	leave  
  1000ff:	c3                   	ret    

00100100 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100100:	55                   	push   %ebp
  100101:	89 e5                	mov    %esp,%ebp
  100103:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100106:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100109:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  10010c:	8c 45 f2             	mov    %es,-0xe(%ebp)
  10010f:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100112:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100116:	0f b7 c0             	movzwl %ax,%eax
  100119:	83 e0 03             	and    $0x3,%eax
  10011c:	89 c2                	mov    %eax,%edx
  10011e:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100123:	89 54 24 08          	mov    %edx,0x8(%esp)
  100127:	89 44 24 04          	mov    %eax,0x4(%esp)
  10012b:	c7 04 24 a1 33 10 00 	movl   $0x1033a1,(%esp)
  100132:	e8 db 01 00 00       	call   100312 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100137:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10013b:	0f b7 d0             	movzwl %ax,%edx
  10013e:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100143:	89 54 24 08          	mov    %edx,0x8(%esp)
  100147:	89 44 24 04          	mov    %eax,0x4(%esp)
  10014b:	c7 04 24 af 33 10 00 	movl   $0x1033af,(%esp)
  100152:	e8 bb 01 00 00       	call   100312 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100157:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  10015b:	0f b7 d0             	movzwl %ax,%edx
  10015e:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100163:	89 54 24 08          	mov    %edx,0x8(%esp)
  100167:	89 44 24 04          	mov    %eax,0x4(%esp)
  10016b:	c7 04 24 bd 33 10 00 	movl   $0x1033bd,(%esp)
  100172:	e8 9b 01 00 00       	call   100312 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  100177:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10017b:	0f b7 d0             	movzwl %ax,%edx
  10017e:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100183:	89 54 24 08          	mov    %edx,0x8(%esp)
  100187:	89 44 24 04          	mov    %eax,0x4(%esp)
  10018b:	c7 04 24 cb 33 10 00 	movl   $0x1033cb,(%esp)
  100192:	e8 7b 01 00 00       	call   100312 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  100197:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  10019b:	0f b7 d0             	movzwl %ax,%edx
  10019e:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001a3:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001a7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001ab:	c7 04 24 d9 33 10 00 	movl   $0x1033d9,(%esp)
  1001b2:	e8 5b 01 00 00       	call   100312 <cprintf>
    round ++;
  1001b7:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001bc:	83 c0 01             	add    $0x1,%eax
  1001bf:	a3 20 ea 10 00       	mov    %eax,0x10ea20
}
  1001c4:	c9                   	leave  
  1001c5:	c3                   	ret    

001001c6 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001c6:	55                   	push   %ebp
  1001c7:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
}
  1001c9:	5d                   	pop    %ebp
  1001ca:	c3                   	ret    

001001cb <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001cb:	55                   	push   %ebp
  1001cc:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
}
  1001ce:	5d                   	pop    %ebp
  1001cf:	c3                   	ret    

001001d0 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001d0:	55                   	push   %ebp
  1001d1:	89 e5                	mov    %esp,%ebp
  1001d3:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  1001d6:	e8 25 ff ff ff       	call   100100 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001db:	c7 04 24 e8 33 10 00 	movl   $0x1033e8,(%esp)
  1001e2:	e8 2b 01 00 00       	call   100312 <cprintf>
    lab1_switch_to_user();
  1001e7:	e8 da ff ff ff       	call   1001c6 <lab1_switch_to_user>
    lab1_print_cur_status();
  1001ec:	e8 0f ff ff ff       	call   100100 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  1001f1:	c7 04 24 08 34 10 00 	movl   $0x103408,(%esp)
  1001f8:	e8 15 01 00 00       	call   100312 <cprintf>
    lab1_switch_to_kernel();
  1001fd:	e8 c9 ff ff ff       	call   1001cb <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100202:	e8 f9 fe ff ff       	call   100100 <lab1_print_cur_status>
}
  100207:	c9                   	leave  
  100208:	c3                   	ret    

00100209 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100209:	55                   	push   %ebp
  10020a:	89 e5                	mov    %esp,%ebp
  10020c:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  10020f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100213:	74 13                	je     100228 <readline+0x1f>
        cprintf("%s", prompt);
  100215:	8b 45 08             	mov    0x8(%ebp),%eax
  100218:	89 44 24 04          	mov    %eax,0x4(%esp)
  10021c:	c7 04 24 27 34 10 00 	movl   $0x103427,(%esp)
  100223:	e8 ea 00 00 00       	call   100312 <cprintf>
    }
    int i = 0, c;
  100228:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  10022f:	e8 66 01 00 00       	call   10039a <getchar>
  100234:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100237:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10023b:	79 07                	jns    100244 <readline+0x3b>
            return NULL;
  10023d:	b8 00 00 00 00       	mov    $0x0,%eax
  100242:	eb 79                	jmp    1002bd <readline+0xb4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100244:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100248:	7e 28                	jle    100272 <readline+0x69>
  10024a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100251:	7f 1f                	jg     100272 <readline+0x69>
            cputchar(c);
  100253:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100256:	89 04 24             	mov    %eax,(%esp)
  100259:	e8 da 00 00 00       	call   100338 <cputchar>
            buf[i ++] = c;
  10025e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100261:	8d 50 01             	lea    0x1(%eax),%edx
  100264:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100267:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10026a:	88 90 40 ea 10 00    	mov    %dl,0x10ea40(%eax)
  100270:	eb 46                	jmp    1002b8 <readline+0xaf>
        }
        else if (c == '\b' && i > 0) {
  100272:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  100276:	75 17                	jne    10028f <readline+0x86>
  100278:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10027c:	7e 11                	jle    10028f <readline+0x86>
            cputchar(c);
  10027e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100281:	89 04 24             	mov    %eax,(%esp)
  100284:	e8 af 00 00 00       	call   100338 <cputchar>
            i --;
  100289:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  10028d:	eb 29                	jmp    1002b8 <readline+0xaf>
        }
        else if (c == '\n' || c == '\r') {
  10028f:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  100293:	74 06                	je     10029b <readline+0x92>
  100295:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  100299:	75 1d                	jne    1002b8 <readline+0xaf>
            cputchar(c);
  10029b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10029e:	89 04 24             	mov    %eax,(%esp)
  1002a1:	e8 92 00 00 00       	call   100338 <cputchar>
            buf[i] = '\0';
  1002a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1002a9:	05 40 ea 10 00       	add    $0x10ea40,%eax
  1002ae:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1002b1:	b8 40 ea 10 00       	mov    $0x10ea40,%eax
  1002b6:	eb 05                	jmp    1002bd <readline+0xb4>
        }
    }
  1002b8:	e9 72 ff ff ff       	jmp    10022f <readline+0x26>
}
  1002bd:	c9                   	leave  
  1002be:	c3                   	ret    

001002bf <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  1002bf:	55                   	push   %ebp
  1002c0:	89 e5                	mov    %esp,%ebp
  1002c2:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1002c8:	89 04 24             	mov    %eax,(%esp)
  1002cb:	e8 07 12 00 00       	call   1014d7 <cons_putc>
    (*cnt) ++;
  1002d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002d3:	8b 00                	mov    (%eax),%eax
  1002d5:	8d 50 01             	lea    0x1(%eax),%edx
  1002d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002db:	89 10                	mov    %edx,(%eax)
}
  1002dd:	c9                   	leave  
  1002de:	c3                   	ret    

001002df <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  1002df:	55                   	push   %ebp
  1002e0:	89 e5                	mov    %esp,%ebp
  1002e2:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  1002ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002ef:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1002f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1002f6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1002fa:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1002fd:	89 44 24 04          	mov    %eax,0x4(%esp)
  100301:	c7 04 24 bf 02 10 00 	movl   $0x1002bf,(%esp)
  100308:	e8 f8 26 00 00       	call   102a05 <vprintfmt>
    return cnt;
  10030d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100310:	c9                   	leave  
  100311:	c3                   	ret    

00100312 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100312:	55                   	push   %ebp
  100313:	89 e5                	mov    %esp,%ebp
  100315:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100318:	8d 45 0c             	lea    0xc(%ebp),%eax
  10031b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  10031e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100321:	89 44 24 04          	mov    %eax,0x4(%esp)
  100325:	8b 45 08             	mov    0x8(%ebp),%eax
  100328:	89 04 24             	mov    %eax,(%esp)
  10032b:	e8 af ff ff ff       	call   1002df <vcprintf>
  100330:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  100333:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100336:	c9                   	leave  
  100337:	c3                   	ret    

00100338 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100338:	55                   	push   %ebp
  100339:	89 e5                	mov    %esp,%ebp
  10033b:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  10033e:	8b 45 08             	mov    0x8(%ebp),%eax
  100341:	89 04 24             	mov    %eax,(%esp)
  100344:	e8 8e 11 00 00       	call   1014d7 <cons_putc>
}
  100349:	c9                   	leave  
  10034a:	c3                   	ret    

0010034b <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10034b:	55                   	push   %ebp
  10034c:	89 e5                	mov    %esp,%ebp
  10034e:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100351:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100358:	eb 13                	jmp    10036d <cputs+0x22>
        cputch(c, &cnt);
  10035a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  10035e:	8d 55 f0             	lea    -0x10(%ebp),%edx
  100361:	89 54 24 04          	mov    %edx,0x4(%esp)
  100365:	89 04 24             	mov    %eax,(%esp)
  100368:	e8 52 ff ff ff       	call   1002bf <cputch>
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
  10036d:	8b 45 08             	mov    0x8(%ebp),%eax
  100370:	8d 50 01             	lea    0x1(%eax),%edx
  100373:	89 55 08             	mov    %edx,0x8(%ebp)
  100376:	0f b6 00             	movzbl (%eax),%eax
  100379:	88 45 f7             	mov    %al,-0x9(%ebp)
  10037c:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  100380:	75 d8                	jne    10035a <cputs+0xf>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
  100382:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100385:	89 44 24 04          	mov    %eax,0x4(%esp)
  100389:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  100390:	e8 2a ff ff ff       	call   1002bf <cputch>
    return cnt;
  100395:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100398:	c9                   	leave  
  100399:	c3                   	ret    

0010039a <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  10039a:	55                   	push   %ebp
  10039b:	89 e5                	mov    %esp,%ebp
  10039d:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  1003a0:	e8 5b 11 00 00       	call   101500 <cons_getc>
  1003a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003ac:	74 f2                	je     1003a0 <getchar+0x6>
        /* do nothing */;
    return c;
  1003ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1003b1:	c9                   	leave  
  1003b2:	c3                   	ret    

001003b3 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1003b3:	55                   	push   %ebp
  1003b4:	89 e5                	mov    %esp,%ebp
  1003b6:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1003b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003bc:	8b 00                	mov    (%eax),%eax
  1003be:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1003c1:	8b 45 10             	mov    0x10(%ebp),%eax
  1003c4:	8b 00                	mov    (%eax),%eax
  1003c6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1003c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1003d0:	e9 d2 00 00 00       	jmp    1004a7 <stab_binsearch+0xf4>
        int true_m = (l + r) / 2, m = true_m;
  1003d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1003d8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1003db:	01 d0                	add    %edx,%eax
  1003dd:	89 c2                	mov    %eax,%edx
  1003df:	c1 ea 1f             	shr    $0x1f,%edx
  1003e2:	01 d0                	add    %edx,%eax
  1003e4:	d1 f8                	sar    %eax
  1003e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1003e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1003ec:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1003ef:	eb 04                	jmp    1003f5 <stab_binsearch+0x42>
            m --;
  1003f1:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)

    while (l <= r) {
        int true_m = (l + r) / 2, m = true_m;

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1003f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003f8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1003fb:	7c 1f                	jl     10041c <stab_binsearch+0x69>
  1003fd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100400:	89 d0                	mov    %edx,%eax
  100402:	01 c0                	add    %eax,%eax
  100404:	01 d0                	add    %edx,%eax
  100406:	c1 e0 02             	shl    $0x2,%eax
  100409:	89 c2                	mov    %eax,%edx
  10040b:	8b 45 08             	mov    0x8(%ebp),%eax
  10040e:	01 d0                	add    %edx,%eax
  100410:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100414:	0f b6 c0             	movzbl %al,%eax
  100417:	3b 45 14             	cmp    0x14(%ebp),%eax
  10041a:	75 d5                	jne    1003f1 <stab_binsearch+0x3e>
            m --;
        }
        if (m < l) {    // no match in [l, m]
  10041c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10041f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100422:	7d 0b                	jge    10042f <stab_binsearch+0x7c>
            l = true_m + 1;
  100424:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100427:	83 c0 01             	add    $0x1,%eax
  10042a:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10042d:	eb 78                	jmp    1004a7 <stab_binsearch+0xf4>
        }

        // actual binary search
        any_matches = 1;
  10042f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100436:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100439:	89 d0                	mov    %edx,%eax
  10043b:	01 c0                	add    %eax,%eax
  10043d:	01 d0                	add    %edx,%eax
  10043f:	c1 e0 02             	shl    $0x2,%eax
  100442:	89 c2                	mov    %eax,%edx
  100444:	8b 45 08             	mov    0x8(%ebp),%eax
  100447:	01 d0                	add    %edx,%eax
  100449:	8b 40 08             	mov    0x8(%eax),%eax
  10044c:	3b 45 18             	cmp    0x18(%ebp),%eax
  10044f:	73 13                	jae    100464 <stab_binsearch+0xb1>
            *region_left = m;
  100451:	8b 45 0c             	mov    0xc(%ebp),%eax
  100454:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100457:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100459:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10045c:	83 c0 01             	add    $0x1,%eax
  10045f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100462:	eb 43                	jmp    1004a7 <stab_binsearch+0xf4>
        } else if (stabs[m].n_value > addr) {
  100464:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100467:	89 d0                	mov    %edx,%eax
  100469:	01 c0                	add    %eax,%eax
  10046b:	01 d0                	add    %edx,%eax
  10046d:	c1 e0 02             	shl    $0x2,%eax
  100470:	89 c2                	mov    %eax,%edx
  100472:	8b 45 08             	mov    0x8(%ebp),%eax
  100475:	01 d0                	add    %edx,%eax
  100477:	8b 40 08             	mov    0x8(%eax),%eax
  10047a:	3b 45 18             	cmp    0x18(%ebp),%eax
  10047d:	76 16                	jbe    100495 <stab_binsearch+0xe2>
            *region_right = m - 1;
  10047f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100482:	8d 50 ff             	lea    -0x1(%eax),%edx
  100485:	8b 45 10             	mov    0x10(%ebp),%eax
  100488:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  10048a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10048d:	83 e8 01             	sub    $0x1,%eax
  100490:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100493:	eb 12                	jmp    1004a7 <stab_binsearch+0xf4>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  100495:	8b 45 0c             	mov    0xc(%ebp),%eax
  100498:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10049b:	89 10                	mov    %edx,(%eax)
            l = m;
  10049d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1004a3:	83 45 18 01          	addl   $0x1,0x18(%ebp)
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
    int l = *region_left, r = *region_right, any_matches = 0;

    while (l <= r) {
  1004a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1004aa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1004ad:	0f 8e 22 ff ff ff    	jle    1003d5 <stab_binsearch+0x22>
            l = m;
            addr ++;
        }
    }

    if (!any_matches) {
  1004b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1004b7:	75 0f                	jne    1004c8 <stab_binsearch+0x115>
        *region_right = *region_left - 1;
  1004b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004bc:	8b 00                	mov    (%eax),%eax
  1004be:	8d 50 ff             	lea    -0x1(%eax),%edx
  1004c1:	8b 45 10             	mov    0x10(%ebp),%eax
  1004c4:	89 10                	mov    %edx,(%eax)
  1004c6:	eb 3f                	jmp    100507 <stab_binsearch+0x154>
    }
    else {
        // find rightmost region containing 'addr'
        l = *region_right;
  1004c8:	8b 45 10             	mov    0x10(%ebp),%eax
  1004cb:	8b 00                	mov    (%eax),%eax
  1004cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1004d0:	eb 04                	jmp    1004d6 <stab_binsearch+0x123>
  1004d2:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1004d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004d9:	8b 00                	mov    (%eax),%eax
  1004db:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004de:	7d 1f                	jge    1004ff <stab_binsearch+0x14c>
  1004e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004e3:	89 d0                	mov    %edx,%eax
  1004e5:	01 c0                	add    %eax,%eax
  1004e7:	01 d0                	add    %edx,%eax
  1004e9:	c1 e0 02             	shl    $0x2,%eax
  1004ec:	89 c2                	mov    %eax,%edx
  1004ee:	8b 45 08             	mov    0x8(%ebp),%eax
  1004f1:	01 d0                	add    %edx,%eax
  1004f3:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1004f7:	0f b6 c0             	movzbl %al,%eax
  1004fa:	3b 45 14             	cmp    0x14(%ebp),%eax
  1004fd:	75 d3                	jne    1004d2 <stab_binsearch+0x11f>
            /* do nothing */;
        *region_left = l;
  1004ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  100502:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100505:	89 10                	mov    %edx,(%eax)
    }
}
  100507:	c9                   	leave  
  100508:	c3                   	ret    

00100509 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100509:	55                   	push   %ebp
  10050a:	89 e5                	mov    %esp,%ebp
  10050c:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  10050f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100512:	c7 00 2c 34 10 00    	movl   $0x10342c,(%eax)
    info->eip_line = 0;
  100518:	8b 45 0c             	mov    0xc(%ebp),%eax
  10051b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100522:	8b 45 0c             	mov    0xc(%ebp),%eax
  100525:	c7 40 08 2c 34 10 00 	movl   $0x10342c,0x8(%eax)
    info->eip_fn_namelen = 9;
  10052c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10052f:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100536:	8b 45 0c             	mov    0xc(%ebp),%eax
  100539:	8b 55 08             	mov    0x8(%ebp),%edx
  10053c:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10053f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100542:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100549:	c7 45 f4 4c 3c 10 00 	movl   $0x103c4c,-0xc(%ebp)
    stab_end = __STAB_END__;
  100550:	c7 45 f0 f4 b1 10 00 	movl   $0x10b1f4,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100557:	c7 45 ec f5 b1 10 00 	movl   $0x10b1f5,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  10055e:	c7 45 e8 c3 d1 10 00 	movl   $0x10d1c3,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100565:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100568:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10056b:	76 0d                	jbe    10057a <debuginfo_eip+0x71>
  10056d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100570:	83 e8 01             	sub    $0x1,%eax
  100573:	0f b6 00             	movzbl (%eax),%eax
  100576:	84 c0                	test   %al,%al
  100578:	74 0a                	je     100584 <debuginfo_eip+0x7b>
        return -1;
  10057a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10057f:	e9 c0 02 00 00       	jmp    100844 <debuginfo_eip+0x33b>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100584:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  10058b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10058e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100591:	29 c2                	sub    %eax,%edx
  100593:	89 d0                	mov    %edx,%eax
  100595:	c1 f8 02             	sar    $0x2,%eax
  100598:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  10059e:	83 e8 01             	sub    $0x1,%eax
  1005a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1005a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1005a7:	89 44 24 10          	mov    %eax,0x10(%esp)
  1005ab:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1005b2:	00 
  1005b3:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1005b6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1005ba:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1005bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1005c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005c4:	89 04 24             	mov    %eax,(%esp)
  1005c7:	e8 e7 fd ff ff       	call   1003b3 <stab_binsearch>
    if (lfile == 0)
  1005cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005cf:	85 c0                	test   %eax,%eax
  1005d1:	75 0a                	jne    1005dd <debuginfo_eip+0xd4>
        return -1;
  1005d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1005d8:	e9 67 02 00 00       	jmp    100844 <debuginfo_eip+0x33b>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1005dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005e0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1005e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1005e6:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1005e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1005ec:	89 44 24 10          	mov    %eax,0x10(%esp)
  1005f0:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  1005f7:	00 
  1005f8:	8d 45 d8             	lea    -0x28(%ebp),%eax
  1005fb:	89 44 24 08          	mov    %eax,0x8(%esp)
  1005ff:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100602:	89 44 24 04          	mov    %eax,0x4(%esp)
  100606:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100609:	89 04 24             	mov    %eax,(%esp)
  10060c:	e8 a2 fd ff ff       	call   1003b3 <stab_binsearch>

    if (lfun <= rfun) {
  100611:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100614:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100617:	39 c2                	cmp    %eax,%edx
  100619:	7f 7c                	jg     100697 <debuginfo_eip+0x18e>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10061b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10061e:	89 c2                	mov    %eax,%edx
  100620:	89 d0                	mov    %edx,%eax
  100622:	01 c0                	add    %eax,%eax
  100624:	01 d0                	add    %edx,%eax
  100626:	c1 e0 02             	shl    $0x2,%eax
  100629:	89 c2                	mov    %eax,%edx
  10062b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10062e:	01 d0                	add    %edx,%eax
  100630:	8b 10                	mov    (%eax),%edx
  100632:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100635:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100638:	29 c1                	sub    %eax,%ecx
  10063a:	89 c8                	mov    %ecx,%eax
  10063c:	39 c2                	cmp    %eax,%edx
  10063e:	73 22                	jae    100662 <debuginfo_eip+0x159>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100640:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100643:	89 c2                	mov    %eax,%edx
  100645:	89 d0                	mov    %edx,%eax
  100647:	01 c0                	add    %eax,%eax
  100649:	01 d0                	add    %edx,%eax
  10064b:	c1 e0 02             	shl    $0x2,%eax
  10064e:	89 c2                	mov    %eax,%edx
  100650:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100653:	01 d0                	add    %edx,%eax
  100655:	8b 10                	mov    (%eax),%edx
  100657:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10065a:	01 c2                	add    %eax,%edx
  10065c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10065f:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100662:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100665:	89 c2                	mov    %eax,%edx
  100667:	89 d0                	mov    %edx,%eax
  100669:	01 c0                	add    %eax,%eax
  10066b:	01 d0                	add    %edx,%eax
  10066d:	c1 e0 02             	shl    $0x2,%eax
  100670:	89 c2                	mov    %eax,%edx
  100672:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100675:	01 d0                	add    %edx,%eax
  100677:	8b 50 08             	mov    0x8(%eax),%edx
  10067a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10067d:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100680:	8b 45 0c             	mov    0xc(%ebp),%eax
  100683:	8b 40 10             	mov    0x10(%eax),%eax
  100686:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  100689:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10068c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  10068f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100692:	89 45 d0             	mov    %eax,-0x30(%ebp)
  100695:	eb 15                	jmp    1006ac <debuginfo_eip+0x1a3>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  100697:	8b 45 0c             	mov    0xc(%ebp),%eax
  10069a:	8b 55 08             	mov    0x8(%ebp),%edx
  10069d:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1006a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006a3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1006a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006a9:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1006ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006af:	8b 40 08             	mov    0x8(%eax),%eax
  1006b2:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1006b9:	00 
  1006ba:	89 04 24             	mov    %eax,(%esp)
  1006bd:	e8 9e 29 00 00       	call   103060 <strfind>
  1006c2:	89 c2                	mov    %eax,%edx
  1006c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006c7:	8b 40 08             	mov    0x8(%eax),%eax
  1006ca:	29 c2                	sub    %eax,%edx
  1006cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006cf:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1006d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1006d5:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006d9:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1006e0:	00 
  1006e1:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1006e4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006e8:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1006eb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006f2:	89 04 24             	mov    %eax,(%esp)
  1006f5:	e8 b9 fc ff ff       	call   1003b3 <stab_binsearch>
    if (lline <= rline) {
  1006fa:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1006fd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100700:	39 c2                	cmp    %eax,%edx
  100702:	7f 24                	jg     100728 <debuginfo_eip+0x21f>
        info->eip_line = stabs[rline].n_desc;
  100704:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100707:	89 c2                	mov    %eax,%edx
  100709:	89 d0                	mov    %edx,%eax
  10070b:	01 c0                	add    %eax,%eax
  10070d:	01 d0                	add    %edx,%eax
  10070f:	c1 e0 02             	shl    $0x2,%eax
  100712:	89 c2                	mov    %eax,%edx
  100714:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100717:	01 d0                	add    %edx,%eax
  100719:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  10071d:	0f b7 d0             	movzwl %ax,%edx
  100720:	8b 45 0c             	mov    0xc(%ebp),%eax
  100723:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100726:	eb 13                	jmp    10073b <debuginfo_eip+0x232>
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
    if (lline <= rline) {
        info->eip_line = stabs[rline].n_desc;
    } else {
        return -1;
  100728:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10072d:	e9 12 01 00 00       	jmp    100844 <debuginfo_eip+0x33b>
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100732:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100735:	83 e8 01             	sub    $0x1,%eax
  100738:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  10073b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10073e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100741:	39 c2                	cmp    %eax,%edx
  100743:	7c 56                	jl     10079b <debuginfo_eip+0x292>
           && stabs[lline].n_type != N_SOL
  100745:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100748:	89 c2                	mov    %eax,%edx
  10074a:	89 d0                	mov    %edx,%eax
  10074c:	01 c0                	add    %eax,%eax
  10074e:	01 d0                	add    %edx,%eax
  100750:	c1 e0 02             	shl    $0x2,%eax
  100753:	89 c2                	mov    %eax,%edx
  100755:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100758:	01 d0                	add    %edx,%eax
  10075a:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10075e:	3c 84                	cmp    $0x84,%al
  100760:	74 39                	je     10079b <debuginfo_eip+0x292>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100762:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100765:	89 c2                	mov    %eax,%edx
  100767:	89 d0                	mov    %edx,%eax
  100769:	01 c0                	add    %eax,%eax
  10076b:	01 d0                	add    %edx,%eax
  10076d:	c1 e0 02             	shl    $0x2,%eax
  100770:	89 c2                	mov    %eax,%edx
  100772:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100775:	01 d0                	add    %edx,%eax
  100777:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10077b:	3c 64                	cmp    $0x64,%al
  10077d:	75 b3                	jne    100732 <debuginfo_eip+0x229>
  10077f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100782:	89 c2                	mov    %eax,%edx
  100784:	89 d0                	mov    %edx,%eax
  100786:	01 c0                	add    %eax,%eax
  100788:	01 d0                	add    %edx,%eax
  10078a:	c1 e0 02             	shl    $0x2,%eax
  10078d:	89 c2                	mov    %eax,%edx
  10078f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100792:	01 d0                	add    %edx,%eax
  100794:	8b 40 08             	mov    0x8(%eax),%eax
  100797:	85 c0                	test   %eax,%eax
  100799:	74 97                	je     100732 <debuginfo_eip+0x229>
        lline --;
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  10079b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10079e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007a1:	39 c2                	cmp    %eax,%edx
  1007a3:	7c 46                	jl     1007eb <debuginfo_eip+0x2e2>
  1007a5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007a8:	89 c2                	mov    %eax,%edx
  1007aa:	89 d0                	mov    %edx,%eax
  1007ac:	01 c0                	add    %eax,%eax
  1007ae:	01 d0                	add    %edx,%eax
  1007b0:	c1 e0 02             	shl    $0x2,%eax
  1007b3:	89 c2                	mov    %eax,%edx
  1007b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007b8:	01 d0                	add    %edx,%eax
  1007ba:	8b 10                	mov    (%eax),%edx
  1007bc:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1007bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007c2:	29 c1                	sub    %eax,%ecx
  1007c4:	89 c8                	mov    %ecx,%eax
  1007c6:	39 c2                	cmp    %eax,%edx
  1007c8:	73 21                	jae    1007eb <debuginfo_eip+0x2e2>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1007ca:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007cd:	89 c2                	mov    %eax,%edx
  1007cf:	89 d0                	mov    %edx,%eax
  1007d1:	01 c0                	add    %eax,%eax
  1007d3:	01 d0                	add    %edx,%eax
  1007d5:	c1 e0 02             	shl    $0x2,%eax
  1007d8:	89 c2                	mov    %eax,%edx
  1007da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007dd:	01 d0                	add    %edx,%eax
  1007df:	8b 10                	mov    (%eax),%edx
  1007e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007e4:	01 c2                	add    %eax,%edx
  1007e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007e9:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1007eb:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1007ee:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1007f1:	39 c2                	cmp    %eax,%edx
  1007f3:	7d 4a                	jge    10083f <debuginfo_eip+0x336>
        for (lline = lfun + 1;
  1007f5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1007f8:	83 c0 01             	add    $0x1,%eax
  1007fb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1007fe:	eb 18                	jmp    100818 <debuginfo_eip+0x30f>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100800:	8b 45 0c             	mov    0xc(%ebp),%eax
  100803:	8b 40 14             	mov    0x14(%eax),%eax
  100806:	8d 50 01             	lea    0x1(%eax),%edx
  100809:	8b 45 0c             	mov    0xc(%ebp),%eax
  10080c:	89 50 14             	mov    %edx,0x14(%eax)
    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
  10080f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100812:	83 c0 01             	add    $0x1,%eax
  100815:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100818:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10081b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
  10081e:	39 c2                	cmp    %eax,%edx
  100820:	7d 1d                	jge    10083f <debuginfo_eip+0x336>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100822:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100825:	89 c2                	mov    %eax,%edx
  100827:	89 d0                	mov    %edx,%eax
  100829:	01 c0                	add    %eax,%eax
  10082b:	01 d0                	add    %edx,%eax
  10082d:	c1 e0 02             	shl    $0x2,%eax
  100830:	89 c2                	mov    %eax,%edx
  100832:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100835:	01 d0                	add    %edx,%eax
  100837:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10083b:	3c a0                	cmp    $0xa0,%al
  10083d:	74 c1                	je     100800 <debuginfo_eip+0x2f7>
             lline ++) {
            info->eip_fn_narg ++;
        }
    }
    return 0;
  10083f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100844:	c9                   	leave  
  100845:	c3                   	ret    

00100846 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100846:	55                   	push   %ebp
  100847:	89 e5                	mov    %esp,%ebp
  100849:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  10084c:	c7 04 24 36 34 10 00 	movl   $0x103436,(%esp)
  100853:	e8 ba fa ff ff       	call   100312 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100858:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10085f:	00 
  100860:	c7 04 24 4f 34 10 00 	movl   $0x10344f,(%esp)
  100867:	e8 a6 fa ff ff       	call   100312 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  10086c:	c7 44 24 04 75 33 10 	movl   $0x103375,0x4(%esp)
  100873:	00 
  100874:	c7 04 24 67 34 10 00 	movl   $0x103467,(%esp)
  10087b:	e8 92 fa ff ff       	call   100312 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  100880:	c7 44 24 04 16 ea 10 	movl   $0x10ea16,0x4(%esp)
  100887:	00 
  100888:	c7 04 24 7f 34 10 00 	movl   $0x10347f,(%esp)
  10088f:	e8 7e fa ff ff       	call   100312 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  100894:	c7 44 24 04 20 fd 10 	movl   $0x10fd20,0x4(%esp)
  10089b:	00 
  10089c:	c7 04 24 97 34 10 00 	movl   $0x103497,(%esp)
  1008a3:	e8 6a fa ff ff       	call   100312 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1008a8:	b8 20 fd 10 00       	mov    $0x10fd20,%eax
  1008ad:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008b3:	b8 00 00 10 00       	mov    $0x100000,%eax
  1008b8:	29 c2                	sub    %eax,%edx
  1008ba:	89 d0                	mov    %edx,%eax
  1008bc:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008c2:	85 c0                	test   %eax,%eax
  1008c4:	0f 48 c2             	cmovs  %edx,%eax
  1008c7:	c1 f8 0a             	sar    $0xa,%eax
  1008ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008ce:	c7 04 24 b0 34 10 00 	movl   $0x1034b0,(%esp)
  1008d5:	e8 38 fa ff ff       	call   100312 <cprintf>
}
  1008da:	c9                   	leave  
  1008db:	c3                   	ret    

001008dc <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1008dc:	55                   	push   %ebp
  1008dd:	89 e5                	mov    %esp,%ebp
  1008df:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1008e5:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1008e8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  1008ef:	89 04 24             	mov    %eax,(%esp)
  1008f2:	e8 12 fc ff ff       	call   100509 <debuginfo_eip>
  1008f7:	85 c0                	test   %eax,%eax
  1008f9:	74 15                	je     100910 <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  1008fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1008fe:	89 44 24 04          	mov    %eax,0x4(%esp)
  100902:	c7 04 24 da 34 10 00 	movl   $0x1034da,(%esp)
  100909:	e8 04 fa ff ff       	call   100312 <cprintf>
  10090e:	eb 6d                	jmp    10097d <print_debuginfo+0xa1>
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100910:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100917:	eb 1c                	jmp    100935 <print_debuginfo+0x59>
            fnname[j] = info.eip_fn_name[j];
  100919:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10091c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10091f:	01 d0                	add    %edx,%eax
  100921:	0f b6 00             	movzbl (%eax),%eax
  100924:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  10092a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10092d:	01 ca                	add    %ecx,%edx
  10092f:	88 02                	mov    %al,(%edx)
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100931:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100935:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100938:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  10093b:	7f dc                	jg     100919 <print_debuginfo+0x3d>
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
  10093d:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100943:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100946:	01 d0                	add    %edx,%eax
  100948:	c6 00 00             	movb   $0x0,(%eax)
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
  10094b:	8b 45 ec             	mov    -0x14(%ebp),%eax
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  10094e:	8b 55 08             	mov    0x8(%ebp),%edx
  100951:	89 d1                	mov    %edx,%ecx
  100953:	29 c1                	sub    %eax,%ecx
  100955:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100958:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10095b:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  10095f:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100965:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100969:	89 54 24 08          	mov    %edx,0x8(%esp)
  10096d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100971:	c7 04 24 f6 34 10 00 	movl   $0x1034f6,(%esp)
  100978:	e8 95 f9 ff ff       	call   100312 <cprintf>
                fnname, eip - info.eip_fn_addr);
    }
}
  10097d:	c9                   	leave  
  10097e:	c3                   	ret    

0010097f <read_eip>:

static __noinline uint32_t
read_eip(void) {
  10097f:	55                   	push   %ebp
  100980:	89 e5                	mov    %esp,%ebp
  100982:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100985:	8b 45 04             	mov    0x4(%ebp),%eax
  100988:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  10098b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10098e:	c9                   	leave  
  10098f:	c3                   	ret    

00100990 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100990:	55                   	push   %ebp
  100991:	89 e5                	mov    %esp,%ebp
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
}
  100993:	5d                   	pop    %ebp
  100994:	c3                   	ret    

00100995 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100995:	55                   	push   %ebp
  100996:	89 e5                	mov    %esp,%ebp
  100998:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  10099b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  1009a2:	eb 0c                	jmp    1009b0 <parse+0x1b>
            *buf ++ = '\0';
  1009a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1009a7:	8d 50 01             	lea    0x1(%eax),%edx
  1009aa:	89 55 08             	mov    %edx,0x8(%ebp)
  1009ad:	c6 00 00             	movb   $0x0,(%eax)
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  1009b0:	8b 45 08             	mov    0x8(%ebp),%eax
  1009b3:	0f b6 00             	movzbl (%eax),%eax
  1009b6:	84 c0                	test   %al,%al
  1009b8:	74 1d                	je     1009d7 <parse+0x42>
  1009ba:	8b 45 08             	mov    0x8(%ebp),%eax
  1009bd:	0f b6 00             	movzbl (%eax),%eax
  1009c0:	0f be c0             	movsbl %al,%eax
  1009c3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009c7:	c7 04 24 88 35 10 00 	movl   $0x103588,(%esp)
  1009ce:	e8 5a 26 00 00       	call   10302d <strchr>
  1009d3:	85 c0                	test   %eax,%eax
  1009d5:	75 cd                	jne    1009a4 <parse+0xf>
            *buf ++ = '\0';
        }
        if (*buf == '\0') {
  1009d7:	8b 45 08             	mov    0x8(%ebp),%eax
  1009da:	0f b6 00             	movzbl (%eax),%eax
  1009dd:	84 c0                	test   %al,%al
  1009df:	75 02                	jne    1009e3 <parse+0x4e>
            break;
  1009e1:	eb 67                	jmp    100a4a <parse+0xb5>
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  1009e3:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  1009e7:	75 14                	jne    1009fd <parse+0x68>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  1009e9:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  1009f0:	00 
  1009f1:	c7 04 24 8d 35 10 00 	movl   $0x10358d,(%esp)
  1009f8:	e8 15 f9 ff ff       	call   100312 <cprintf>
        }
        argv[argc ++] = buf;
  1009fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a00:	8d 50 01             	lea    0x1(%eax),%edx
  100a03:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100a06:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100a0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100a10:	01 c2                	add    %eax,%edx
  100a12:	8b 45 08             	mov    0x8(%ebp),%eax
  100a15:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100a17:	eb 04                	jmp    100a1d <parse+0x88>
            buf ++;
  100a19:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        // save and scan past next arg
        if (argc == MAXARGS - 1) {
            cprintf("Too many arguments (max %d).\n", MAXARGS);
        }
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  100a20:	0f b6 00             	movzbl (%eax),%eax
  100a23:	84 c0                	test   %al,%al
  100a25:	74 1d                	je     100a44 <parse+0xaf>
  100a27:	8b 45 08             	mov    0x8(%ebp),%eax
  100a2a:	0f b6 00             	movzbl (%eax),%eax
  100a2d:	0f be c0             	movsbl %al,%eax
  100a30:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a34:	c7 04 24 88 35 10 00 	movl   $0x103588,(%esp)
  100a3b:	e8 ed 25 00 00       	call   10302d <strchr>
  100a40:	85 c0                	test   %eax,%eax
  100a42:	74 d5                	je     100a19 <parse+0x84>
            buf ++;
        }
    }
  100a44:	90                   	nop
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100a45:	e9 66 ff ff ff       	jmp    1009b0 <parse+0x1b>
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
            buf ++;
        }
    }
    return argc;
  100a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100a4d:	c9                   	leave  
  100a4e:	c3                   	ret    

00100a4f <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100a4f:	55                   	push   %ebp
  100a50:	89 e5                	mov    %esp,%ebp
  100a52:	83 ec 68             	sub    $0x68,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100a55:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100a58:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  100a5f:	89 04 24             	mov    %eax,(%esp)
  100a62:	e8 2e ff ff ff       	call   100995 <parse>
  100a67:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100a6a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100a6e:	75 0a                	jne    100a7a <runcmd+0x2b>
        return 0;
  100a70:	b8 00 00 00 00       	mov    $0x0,%eax
  100a75:	e9 85 00 00 00       	jmp    100aff <runcmd+0xb0>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100a7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100a81:	eb 5c                	jmp    100adf <runcmd+0x90>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100a83:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100a86:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100a89:	89 d0                	mov    %edx,%eax
  100a8b:	01 c0                	add    %eax,%eax
  100a8d:	01 d0                	add    %edx,%eax
  100a8f:	c1 e0 02             	shl    $0x2,%eax
  100a92:	05 00 e0 10 00       	add    $0x10e000,%eax
  100a97:	8b 00                	mov    (%eax),%eax
  100a99:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100a9d:	89 04 24             	mov    %eax,(%esp)
  100aa0:	e8 e9 24 00 00       	call   102f8e <strcmp>
  100aa5:	85 c0                	test   %eax,%eax
  100aa7:	75 32                	jne    100adb <runcmd+0x8c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100aa9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100aac:	89 d0                	mov    %edx,%eax
  100aae:	01 c0                	add    %eax,%eax
  100ab0:	01 d0                	add    %edx,%eax
  100ab2:	c1 e0 02             	shl    $0x2,%eax
  100ab5:	05 00 e0 10 00       	add    $0x10e000,%eax
  100aba:	8b 40 08             	mov    0x8(%eax),%eax
  100abd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100ac0:	8d 4a ff             	lea    -0x1(%edx),%ecx
  100ac3:	8b 55 0c             	mov    0xc(%ebp),%edx
  100ac6:	89 54 24 08          	mov    %edx,0x8(%esp)
  100aca:	8d 55 b0             	lea    -0x50(%ebp),%edx
  100acd:	83 c2 04             	add    $0x4,%edx
  100ad0:	89 54 24 04          	mov    %edx,0x4(%esp)
  100ad4:	89 0c 24             	mov    %ecx,(%esp)
  100ad7:	ff d0                	call   *%eax
  100ad9:	eb 24                	jmp    100aff <runcmd+0xb0>
    int argc = parse(buf, argv);
    if (argc == 0) {
        return 0;
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100adb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100adf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ae2:	83 f8 02             	cmp    $0x2,%eax
  100ae5:	76 9c                	jbe    100a83 <runcmd+0x34>
        if (strcmp(commands[i].name, argv[0]) == 0) {
            return commands[i].func(argc - 1, argv + 1, tf);
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100ae7:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100aea:	89 44 24 04          	mov    %eax,0x4(%esp)
  100aee:	c7 04 24 ab 35 10 00 	movl   $0x1035ab,(%esp)
  100af5:	e8 18 f8 ff ff       	call   100312 <cprintf>
    return 0;
  100afa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100aff:	c9                   	leave  
  100b00:	c3                   	ret    

00100b01 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100b01:	55                   	push   %ebp
  100b02:	89 e5                	mov    %esp,%ebp
  100b04:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100b07:	c7 04 24 c4 35 10 00 	movl   $0x1035c4,(%esp)
  100b0e:	e8 ff f7 ff ff       	call   100312 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100b13:	c7 04 24 ec 35 10 00 	movl   $0x1035ec,(%esp)
  100b1a:	e8 f3 f7 ff ff       	call   100312 <cprintf>

    if (tf != NULL) {
  100b1f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100b23:	74 0b                	je     100b30 <kmonitor+0x2f>
        print_trapframe(tf);
  100b25:	8b 45 08             	mov    0x8(%ebp),%eax
  100b28:	89 04 24             	mov    %eax,(%esp)
  100b2b:	e8 cd 0d 00 00       	call   1018fd <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100b30:	c7 04 24 11 36 10 00 	movl   $0x103611,(%esp)
  100b37:	e8 cd f6 ff ff       	call   100209 <readline>
  100b3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100b3f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b43:	74 18                	je     100b5d <kmonitor+0x5c>
            if (runcmd(buf, tf) < 0) {
  100b45:	8b 45 08             	mov    0x8(%ebp),%eax
  100b48:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b4f:	89 04 24             	mov    %eax,(%esp)
  100b52:	e8 f8 fe ff ff       	call   100a4f <runcmd>
  100b57:	85 c0                	test   %eax,%eax
  100b59:	79 02                	jns    100b5d <kmonitor+0x5c>
                break;
  100b5b:	eb 02                	jmp    100b5f <kmonitor+0x5e>
            }
        }
    }
  100b5d:	eb d1                	jmp    100b30 <kmonitor+0x2f>
}
  100b5f:	c9                   	leave  
  100b60:	c3                   	ret    

00100b61 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100b61:	55                   	push   %ebp
  100b62:	89 e5                	mov    %esp,%ebp
  100b64:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100b67:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100b6e:	eb 3f                	jmp    100baf <mon_help+0x4e>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100b70:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b73:	89 d0                	mov    %edx,%eax
  100b75:	01 c0                	add    %eax,%eax
  100b77:	01 d0                	add    %edx,%eax
  100b79:	c1 e0 02             	shl    $0x2,%eax
  100b7c:	05 00 e0 10 00       	add    $0x10e000,%eax
  100b81:	8b 48 04             	mov    0x4(%eax),%ecx
  100b84:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b87:	89 d0                	mov    %edx,%eax
  100b89:	01 c0                	add    %eax,%eax
  100b8b:	01 d0                	add    %edx,%eax
  100b8d:	c1 e0 02             	shl    $0x2,%eax
  100b90:	05 00 e0 10 00       	add    $0x10e000,%eax
  100b95:	8b 00                	mov    (%eax),%eax
  100b97:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100b9b:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b9f:	c7 04 24 15 36 10 00 	movl   $0x103615,(%esp)
  100ba6:	e8 67 f7 ff ff       	call   100312 <cprintf>

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100bab:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100baf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bb2:	83 f8 02             	cmp    $0x2,%eax
  100bb5:	76 b9                	jbe    100b70 <mon_help+0xf>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
    }
    return 0;
  100bb7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100bbc:	c9                   	leave  
  100bbd:	c3                   	ret    

00100bbe <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100bbe:	55                   	push   %ebp
  100bbf:	89 e5                	mov    %esp,%ebp
  100bc1:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100bc4:	e8 7d fc ff ff       	call   100846 <print_kerninfo>
    return 0;
  100bc9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100bce:	c9                   	leave  
  100bcf:	c3                   	ret    

00100bd0 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100bd0:	55                   	push   %ebp
  100bd1:	89 e5                	mov    %esp,%ebp
  100bd3:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100bd6:	e8 b5 fd ff ff       	call   100990 <print_stackframe>
    return 0;
  100bdb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100be0:	c9                   	leave  
  100be1:	c3                   	ret    

00100be2 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  100be2:	55                   	push   %ebp
  100be3:	89 e5                	mov    %esp,%ebp
  100be5:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  100be8:	a1 40 ee 10 00       	mov    0x10ee40,%eax
  100bed:	85 c0                	test   %eax,%eax
  100bef:	74 02                	je     100bf3 <__panic+0x11>
        goto panic_dead;
  100bf1:	eb 48                	jmp    100c3b <__panic+0x59>
    }
    is_panic = 1;
  100bf3:	c7 05 40 ee 10 00 01 	movl   $0x1,0x10ee40
  100bfa:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100bfd:	8d 45 14             	lea    0x14(%ebp),%eax
  100c00:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100c03:	8b 45 0c             	mov    0xc(%ebp),%eax
  100c06:	89 44 24 08          	mov    %eax,0x8(%esp)
  100c0a:	8b 45 08             	mov    0x8(%ebp),%eax
  100c0d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c11:	c7 04 24 1e 36 10 00 	movl   $0x10361e,(%esp)
  100c18:	e8 f5 f6 ff ff       	call   100312 <cprintf>
    vcprintf(fmt, ap);
  100c1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c20:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c24:	8b 45 10             	mov    0x10(%ebp),%eax
  100c27:	89 04 24             	mov    %eax,(%esp)
  100c2a:	e8 b0 f6 ff ff       	call   1002df <vcprintf>
    cprintf("\n");
  100c2f:	c7 04 24 3a 36 10 00 	movl   $0x10363a,(%esp)
  100c36:	e8 d7 f6 ff ff       	call   100312 <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
  100c3b:	e8 22 09 00 00       	call   101562 <intr_disable>
    while (1) {
        kmonitor(NULL);
  100c40:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100c47:	e8 b5 fe ff ff       	call   100b01 <kmonitor>
    }
  100c4c:	eb f2                	jmp    100c40 <__panic+0x5e>

00100c4e <__warn>:
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100c4e:	55                   	push   %ebp
  100c4f:	89 e5                	mov    %esp,%ebp
  100c51:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100c54:	8d 45 14             	lea    0x14(%ebp),%eax
  100c57:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100c5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  100c5d:	89 44 24 08          	mov    %eax,0x8(%esp)
  100c61:	8b 45 08             	mov    0x8(%ebp),%eax
  100c64:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c68:	c7 04 24 3c 36 10 00 	movl   $0x10363c,(%esp)
  100c6f:	e8 9e f6 ff ff       	call   100312 <cprintf>
    vcprintf(fmt, ap);
  100c74:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c77:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c7b:	8b 45 10             	mov    0x10(%ebp),%eax
  100c7e:	89 04 24             	mov    %eax,(%esp)
  100c81:	e8 59 f6 ff ff       	call   1002df <vcprintf>
    cprintf("\n");
  100c86:	c7 04 24 3a 36 10 00 	movl   $0x10363a,(%esp)
  100c8d:	e8 80 f6 ff ff       	call   100312 <cprintf>
    va_end(ap);
}
  100c92:	c9                   	leave  
  100c93:	c3                   	ret    

00100c94 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  100c94:	55                   	push   %ebp
  100c95:	89 e5                	mov    %esp,%ebp
    return is_panic;
  100c97:	a1 40 ee 10 00       	mov    0x10ee40,%eax
}
  100c9c:	5d                   	pop    %ebp
  100c9d:	c3                   	ret    

00100c9e <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100c9e:	55                   	push   %ebp
  100c9f:	89 e5                	mov    %esp,%ebp
  100ca1:	83 ec 28             	sub    $0x28,%esp
  100ca4:	66 c7 45 f6 43 00    	movw   $0x43,-0xa(%ebp)
  100caa:	c6 45 f5 34          	movb   $0x34,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100cae:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100cb2:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100cb6:	ee                   	out    %al,(%dx)
  100cb7:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100cbd:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100cc1:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100cc5:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100cc9:	ee                   	out    %al,(%dx)
  100cca:	66 c7 45 ee 40 00    	movw   $0x40,-0x12(%ebp)
  100cd0:	c6 45 ed 2e          	movb   $0x2e,-0x13(%ebp)
  100cd4:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100cd8:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100cdc:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100cdd:	c7 05 08 f9 10 00 00 	movl   $0x0,0x10f908
  100ce4:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100ce7:	c7 04 24 5a 36 10 00 	movl   $0x10365a,(%esp)
  100cee:	e8 1f f6 ff ff       	call   100312 <cprintf>
    pic_enable(IRQ_TIMER);
  100cf3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100cfa:	e8 c1 08 00 00       	call   1015c0 <pic_enable>
}
  100cff:	c9                   	leave  
  100d00:	c3                   	ret    

00100d01 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100d01:	55                   	push   %ebp
  100d02:	89 e5                	mov    %esp,%ebp
  100d04:	83 ec 10             	sub    $0x10,%esp
  100d07:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100d0d:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100d11:	89 c2                	mov    %eax,%edx
  100d13:	ec                   	in     (%dx),%al
  100d14:	88 45 fd             	mov    %al,-0x3(%ebp)
  100d17:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100d1d:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100d21:	89 c2                	mov    %eax,%edx
  100d23:	ec                   	in     (%dx),%al
  100d24:	88 45 f9             	mov    %al,-0x7(%ebp)
  100d27:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100d2d:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100d31:	89 c2                	mov    %eax,%edx
  100d33:	ec                   	in     (%dx),%al
  100d34:	88 45 f5             	mov    %al,-0xb(%ebp)
  100d37:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
  100d3d:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100d41:	89 c2                	mov    %eax,%edx
  100d43:	ec                   	in     (%dx),%al
  100d44:	88 45 f1             	mov    %al,-0xf(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100d47:	c9                   	leave  
  100d48:	c3                   	ret    

00100d49 <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
  100d49:	55                   	push   %ebp
  100d4a:	89 e5                	mov    %esp,%ebp
  100d4c:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;
  100d4f:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;
  100d56:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100d59:	0f b7 00             	movzwl (%eax),%eax
  100d5c:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
  100d60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100d63:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
  100d68:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100d6b:	0f b7 00             	movzwl (%eax),%eax
  100d6e:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100d72:	74 12                	je     100d86 <cga_init+0x3d>
        cp = (uint16_t*)MONO_BUF;
  100d74:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
  100d7b:	66 c7 05 66 ee 10 00 	movw   $0x3b4,0x10ee66
  100d82:	b4 03 
  100d84:	eb 13                	jmp    100d99 <cga_init+0x50>
    } else {
        *cp = was;
  100d86:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100d89:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100d8d:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
  100d90:	66 c7 05 66 ee 10 00 	movw   $0x3d4,0x10ee66
  100d97:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
  100d99:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100da0:	0f b7 c0             	movzwl %ax,%eax
  100da3:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  100da7:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dab:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100daf:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100db3:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;
  100db4:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100dbb:	83 c0 01             	add    $0x1,%eax
  100dbe:	0f b7 c0             	movzwl %ax,%eax
  100dc1:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100dc5:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100dc9:	89 c2                	mov    %eax,%edx
  100dcb:	ec                   	in     (%dx),%al
  100dcc:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100dcf:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100dd3:	0f b6 c0             	movzbl %al,%eax
  100dd6:	c1 e0 08             	shl    $0x8,%eax
  100dd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100ddc:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100de3:	0f b7 c0             	movzwl %ax,%eax
  100de6:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  100dea:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dee:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100df2:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100df6:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);
  100df7:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100dfe:	83 c0 01             	add    $0x1,%eax
  100e01:	0f b7 c0             	movzwl %ax,%eax
  100e04:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e08:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
  100e0c:	89 c2                	mov    %eax,%edx
  100e0e:	ec                   	in     (%dx),%al
  100e0f:	88 45 e5             	mov    %al,-0x1b(%ebp)
    return data;
  100e12:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100e16:	0f b6 c0             	movzbl %al,%eax
  100e19:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
  100e1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e1f:	a3 60 ee 10 00       	mov    %eax,0x10ee60
    crt_pos = pos;
  100e24:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100e27:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
}
  100e2d:	c9                   	leave  
  100e2e:	c3                   	ret    

00100e2f <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100e2f:	55                   	push   %ebp
  100e30:	89 e5                	mov    %esp,%ebp
  100e32:	83 ec 48             	sub    $0x48,%esp
  100e35:	66 c7 45 f6 fa 03    	movw   $0x3fa,-0xa(%ebp)
  100e3b:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e3f:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100e43:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100e47:	ee                   	out    %al,(%dx)
  100e48:	66 c7 45 f2 fb 03    	movw   $0x3fb,-0xe(%ebp)
  100e4e:	c6 45 f1 80          	movb   $0x80,-0xf(%ebp)
  100e52:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100e56:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100e5a:	ee                   	out    %al,(%dx)
  100e5b:	66 c7 45 ee f8 03    	movw   $0x3f8,-0x12(%ebp)
  100e61:	c6 45 ed 0c          	movb   $0xc,-0x13(%ebp)
  100e65:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100e69:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100e6d:	ee                   	out    %al,(%dx)
  100e6e:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100e74:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
  100e78:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100e7c:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100e80:	ee                   	out    %al,(%dx)
  100e81:	66 c7 45 e6 fb 03    	movw   $0x3fb,-0x1a(%ebp)
  100e87:	c6 45 e5 03          	movb   $0x3,-0x1b(%ebp)
  100e8b:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100e8f:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100e93:	ee                   	out    %al,(%dx)
  100e94:	66 c7 45 e2 fc 03    	movw   $0x3fc,-0x1e(%ebp)
  100e9a:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
  100e9e:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100ea2:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100ea6:	ee                   	out    %al,(%dx)
  100ea7:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100ead:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
  100eb1:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100eb5:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100eb9:	ee                   	out    %al,(%dx)
  100eba:	66 c7 45 da fd 03    	movw   $0x3fd,-0x26(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ec0:	0f b7 45 da          	movzwl -0x26(%ebp),%eax
  100ec4:	89 c2                	mov    %eax,%edx
  100ec6:	ec                   	in     (%dx),%al
  100ec7:	88 45 d9             	mov    %al,-0x27(%ebp)
    return data;
  100eca:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100ece:	3c ff                	cmp    $0xff,%al
  100ed0:	0f 95 c0             	setne  %al
  100ed3:	0f b6 c0             	movzbl %al,%eax
  100ed6:	a3 68 ee 10 00       	mov    %eax,0x10ee68
  100edb:	66 c7 45 d6 fa 03    	movw   $0x3fa,-0x2a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ee1:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
  100ee5:	89 c2                	mov    %eax,%edx
  100ee7:	ec                   	in     (%dx),%al
  100ee8:	88 45 d5             	mov    %al,-0x2b(%ebp)
  100eeb:	66 c7 45 d2 f8 03    	movw   $0x3f8,-0x2e(%ebp)
  100ef1:	0f b7 45 d2          	movzwl -0x2e(%ebp),%eax
  100ef5:	89 c2                	mov    %eax,%edx
  100ef7:	ec                   	in     (%dx),%al
  100ef8:	88 45 d1             	mov    %al,-0x2f(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  100efb:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  100f00:	85 c0                	test   %eax,%eax
  100f02:	74 0c                	je     100f10 <serial_init+0xe1>
        pic_enable(IRQ_COM1);
  100f04:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  100f0b:	e8 b0 06 00 00       	call   1015c0 <pic_enable>
    }
}
  100f10:	c9                   	leave  
  100f11:	c3                   	ret    

00100f12 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  100f12:	55                   	push   %ebp
  100f13:	89 e5                	mov    %esp,%ebp
  100f15:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100f18:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100f1f:	eb 09                	jmp    100f2a <lpt_putc_sub+0x18>
        delay();
  100f21:	e8 db fd ff ff       	call   100d01 <delay>
}

static void
lpt_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100f26:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100f2a:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  100f30:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100f34:	89 c2                	mov    %eax,%edx
  100f36:	ec                   	in     (%dx),%al
  100f37:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  100f3a:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  100f3e:	84 c0                	test   %al,%al
  100f40:	78 09                	js     100f4b <lpt_putc_sub+0x39>
  100f42:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  100f49:	7e d6                	jle    100f21 <lpt_putc_sub+0xf>
        delay();
    }
    outb(LPTPORT + 0, c);
  100f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  100f4e:	0f b6 c0             	movzbl %al,%eax
  100f51:	66 c7 45 f6 78 03    	movw   $0x378,-0xa(%ebp)
  100f57:	88 45 f5             	mov    %al,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f5a:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100f5e:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100f62:	ee                   	out    %al,(%dx)
  100f63:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  100f69:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  100f6d:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f71:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100f75:	ee                   	out    %al,(%dx)
  100f76:	66 c7 45 ee 7a 03    	movw   $0x37a,-0x12(%ebp)
  100f7c:	c6 45 ed 08          	movb   $0x8,-0x13(%ebp)
  100f80:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f84:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f88:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  100f89:	c9                   	leave  
  100f8a:	c3                   	ret    

00100f8b <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  100f8b:	55                   	push   %ebp
  100f8c:	89 e5                	mov    %esp,%ebp
  100f8e:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  100f91:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  100f95:	74 0d                	je     100fa4 <lpt_putc+0x19>
        lpt_putc_sub(c);
  100f97:	8b 45 08             	mov    0x8(%ebp),%eax
  100f9a:	89 04 24             	mov    %eax,(%esp)
  100f9d:	e8 70 ff ff ff       	call   100f12 <lpt_putc_sub>
  100fa2:	eb 24                	jmp    100fc8 <lpt_putc+0x3d>
    }
    else {
        lpt_putc_sub('\b');
  100fa4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100fab:	e8 62 ff ff ff       	call   100f12 <lpt_putc_sub>
        lpt_putc_sub(' ');
  100fb0:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  100fb7:	e8 56 ff ff ff       	call   100f12 <lpt_putc_sub>
        lpt_putc_sub('\b');
  100fbc:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  100fc3:	e8 4a ff ff ff       	call   100f12 <lpt_putc_sub>
    }
}
  100fc8:	c9                   	leave  
  100fc9:	c3                   	ret    

00100fca <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  100fca:	55                   	push   %ebp
  100fcb:	89 e5                	mov    %esp,%ebp
  100fcd:	53                   	push   %ebx
  100fce:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  100fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  100fd4:	b0 00                	mov    $0x0,%al
  100fd6:	85 c0                	test   %eax,%eax
  100fd8:	75 07                	jne    100fe1 <cga_putc+0x17>
        c |= 0x0700;
  100fda:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  100fe1:	8b 45 08             	mov    0x8(%ebp),%eax
  100fe4:	0f b6 c0             	movzbl %al,%eax
  100fe7:	83 f8 0a             	cmp    $0xa,%eax
  100fea:	74 4c                	je     101038 <cga_putc+0x6e>
  100fec:	83 f8 0d             	cmp    $0xd,%eax
  100fef:	74 57                	je     101048 <cga_putc+0x7e>
  100ff1:	83 f8 08             	cmp    $0x8,%eax
  100ff4:	0f 85 88 00 00 00    	jne    101082 <cga_putc+0xb8>
    case '\b':
        if (crt_pos > 0) {
  100ffa:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101001:	66 85 c0             	test   %ax,%ax
  101004:	74 30                	je     101036 <cga_putc+0x6c>
            crt_pos --;
  101006:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10100d:	83 e8 01             	sub    $0x1,%eax
  101010:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101016:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  10101b:	0f b7 15 64 ee 10 00 	movzwl 0x10ee64,%edx
  101022:	0f b7 d2             	movzwl %dx,%edx
  101025:	01 d2                	add    %edx,%edx
  101027:	01 c2                	add    %eax,%edx
  101029:	8b 45 08             	mov    0x8(%ebp),%eax
  10102c:	b0 00                	mov    $0x0,%al
  10102e:	83 c8 20             	or     $0x20,%eax
  101031:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  101034:	eb 72                	jmp    1010a8 <cga_putc+0xde>
  101036:	eb 70                	jmp    1010a8 <cga_putc+0xde>
    case '\n':
        crt_pos += CRT_COLS;
  101038:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10103f:	83 c0 50             	add    $0x50,%eax
  101042:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101048:	0f b7 1d 64 ee 10 00 	movzwl 0x10ee64,%ebx
  10104f:	0f b7 0d 64 ee 10 00 	movzwl 0x10ee64,%ecx
  101056:	0f b7 c1             	movzwl %cx,%eax
  101059:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  10105f:	c1 e8 10             	shr    $0x10,%eax
  101062:	89 c2                	mov    %eax,%edx
  101064:	66 c1 ea 06          	shr    $0x6,%dx
  101068:	89 d0                	mov    %edx,%eax
  10106a:	c1 e0 02             	shl    $0x2,%eax
  10106d:	01 d0                	add    %edx,%eax
  10106f:	c1 e0 04             	shl    $0x4,%eax
  101072:	29 c1                	sub    %eax,%ecx
  101074:	89 ca                	mov    %ecx,%edx
  101076:	89 d8                	mov    %ebx,%eax
  101078:	29 d0                	sub    %edx,%eax
  10107a:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
        break;
  101080:	eb 26                	jmp    1010a8 <cga_putc+0xde>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  101082:	8b 0d 60 ee 10 00    	mov    0x10ee60,%ecx
  101088:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10108f:	8d 50 01             	lea    0x1(%eax),%edx
  101092:	66 89 15 64 ee 10 00 	mov    %dx,0x10ee64
  101099:	0f b7 c0             	movzwl %ax,%eax
  10109c:	01 c0                	add    %eax,%eax
  10109e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  1010a1:	8b 45 08             	mov    0x8(%ebp),%eax
  1010a4:	66 89 02             	mov    %ax,(%edx)
        break;
  1010a7:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  1010a8:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1010af:	66 3d cf 07          	cmp    $0x7cf,%ax
  1010b3:	76 5b                	jbe    101110 <cga_putc+0x146>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  1010b5:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1010ba:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  1010c0:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1010c5:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  1010cc:	00 
  1010cd:	89 54 24 04          	mov    %edx,0x4(%esp)
  1010d1:	89 04 24             	mov    %eax,(%esp)
  1010d4:	e8 52 21 00 00       	call   10322b <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1010d9:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  1010e0:	eb 15                	jmp    1010f7 <cga_putc+0x12d>
            crt_buf[i] = 0x0700 | ' ';
  1010e2:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1010e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1010ea:	01 d2                	add    %edx,%edx
  1010ec:	01 d0                	add    %edx,%eax
  1010ee:	66 c7 00 20 07       	movw   $0x720,(%eax)

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1010f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1010f7:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  1010fe:	7e e2                	jle    1010e2 <cga_putc+0x118>
            crt_buf[i] = 0x0700 | ' ';
        }
        crt_pos -= CRT_COLS;
  101100:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101107:	83 e8 50             	sub    $0x50,%eax
  10110a:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101110:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  101117:	0f b7 c0             	movzwl %ax,%eax
  10111a:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  10111e:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
  101122:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101126:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10112a:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  10112b:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101132:	66 c1 e8 08          	shr    $0x8,%ax
  101136:	0f b6 c0             	movzbl %al,%eax
  101139:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  101140:	83 c2 01             	add    $0x1,%edx
  101143:	0f b7 d2             	movzwl %dx,%edx
  101146:	66 89 55 ee          	mov    %dx,-0x12(%ebp)
  10114a:	88 45 ed             	mov    %al,-0x13(%ebp)
  10114d:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101151:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101155:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  101156:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  10115d:	0f b7 c0             	movzwl %ax,%eax
  101160:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  101164:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
  101168:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10116c:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101170:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  101171:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101178:	0f b6 c0             	movzbl %al,%eax
  10117b:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  101182:	83 c2 01             	add    $0x1,%edx
  101185:	0f b7 d2             	movzwl %dx,%edx
  101188:	66 89 55 e6          	mov    %dx,-0x1a(%ebp)
  10118c:	88 45 e5             	mov    %al,-0x1b(%ebp)
  10118f:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101193:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101197:	ee                   	out    %al,(%dx)
}
  101198:	83 c4 34             	add    $0x34,%esp
  10119b:	5b                   	pop    %ebx
  10119c:	5d                   	pop    %ebp
  10119d:	c3                   	ret    

0010119e <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  10119e:	55                   	push   %ebp
  10119f:	89 e5                	mov    %esp,%ebp
  1011a1:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1011a4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1011ab:	eb 09                	jmp    1011b6 <serial_putc_sub+0x18>
        delay();
  1011ad:	e8 4f fb ff ff       	call   100d01 <delay>
}

static void
serial_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1011b2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1011b6:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1011bc:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1011c0:	89 c2                	mov    %eax,%edx
  1011c2:	ec                   	in     (%dx),%al
  1011c3:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1011c6:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1011ca:	0f b6 c0             	movzbl %al,%eax
  1011cd:	83 e0 20             	and    $0x20,%eax
  1011d0:	85 c0                	test   %eax,%eax
  1011d2:	75 09                	jne    1011dd <serial_putc_sub+0x3f>
  1011d4:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  1011db:	7e d0                	jle    1011ad <serial_putc_sub+0xf>
        delay();
    }
    outb(COM1 + COM_TX, c);
  1011dd:	8b 45 08             	mov    0x8(%ebp),%eax
  1011e0:	0f b6 c0             	movzbl %al,%eax
  1011e3:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1011e9:	88 45 f5             	mov    %al,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1011ec:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1011f0:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1011f4:	ee                   	out    %al,(%dx)
}
  1011f5:	c9                   	leave  
  1011f6:	c3                   	ret    

001011f7 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  1011f7:	55                   	push   %ebp
  1011f8:	89 e5                	mov    %esp,%ebp
  1011fa:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1011fd:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101201:	74 0d                	je     101210 <serial_putc+0x19>
        serial_putc_sub(c);
  101203:	8b 45 08             	mov    0x8(%ebp),%eax
  101206:	89 04 24             	mov    %eax,(%esp)
  101209:	e8 90 ff ff ff       	call   10119e <serial_putc_sub>
  10120e:	eb 24                	jmp    101234 <serial_putc+0x3d>
    }
    else {
        serial_putc_sub('\b');
  101210:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101217:	e8 82 ff ff ff       	call   10119e <serial_putc_sub>
        serial_putc_sub(' ');
  10121c:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101223:	e8 76 ff ff ff       	call   10119e <serial_putc_sub>
        serial_putc_sub('\b');
  101228:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10122f:	e8 6a ff ff ff       	call   10119e <serial_putc_sub>
    }
}
  101234:	c9                   	leave  
  101235:	c3                   	ret    

00101236 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  101236:	55                   	push   %ebp
  101237:	89 e5                	mov    %esp,%ebp
  101239:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  10123c:	eb 33                	jmp    101271 <cons_intr+0x3b>
        if (c != 0) {
  10123e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  101242:	74 2d                	je     101271 <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
  101244:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101249:	8d 50 01             	lea    0x1(%eax),%edx
  10124c:	89 15 84 f0 10 00    	mov    %edx,0x10f084
  101252:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101255:	88 90 80 ee 10 00    	mov    %dl,0x10ee80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  10125b:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101260:	3d 00 02 00 00       	cmp    $0x200,%eax
  101265:	75 0a                	jne    101271 <cons_intr+0x3b>
                cons.wpos = 0;
  101267:	c7 05 84 f0 10 00 00 	movl   $0x0,0x10f084
  10126e:	00 00 00 
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
    int c;
    while ((c = (*proc)()) != -1) {
  101271:	8b 45 08             	mov    0x8(%ebp),%eax
  101274:	ff d0                	call   *%eax
  101276:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101279:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  10127d:	75 bf                	jne    10123e <cons_intr+0x8>
            if (cons.wpos == CONSBUFSIZE) {
                cons.wpos = 0;
            }
        }
    }
}
  10127f:	c9                   	leave  
  101280:	c3                   	ret    

00101281 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  101281:	55                   	push   %ebp
  101282:	89 e5                	mov    %esp,%ebp
  101284:	83 ec 10             	sub    $0x10,%esp
  101287:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10128d:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101291:	89 c2                	mov    %eax,%edx
  101293:	ec                   	in     (%dx),%al
  101294:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101297:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  10129b:	0f b6 c0             	movzbl %al,%eax
  10129e:	83 e0 01             	and    $0x1,%eax
  1012a1:	85 c0                	test   %eax,%eax
  1012a3:	75 07                	jne    1012ac <serial_proc_data+0x2b>
        return -1;
  1012a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1012aa:	eb 2a                	jmp    1012d6 <serial_proc_data+0x55>
  1012ac:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1012b2:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1012b6:	89 c2                	mov    %eax,%edx
  1012b8:	ec                   	in     (%dx),%al
  1012b9:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  1012bc:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  1012c0:	0f b6 c0             	movzbl %al,%eax
  1012c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  1012c6:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  1012ca:	75 07                	jne    1012d3 <serial_proc_data+0x52>
        c = '\b';
  1012cc:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  1012d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1012d6:	c9                   	leave  
  1012d7:	c3                   	ret    

001012d8 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  1012d8:	55                   	push   %ebp
  1012d9:	89 e5                	mov    %esp,%ebp
  1012db:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  1012de:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  1012e3:	85 c0                	test   %eax,%eax
  1012e5:	74 0c                	je     1012f3 <serial_intr+0x1b>
        cons_intr(serial_proc_data);
  1012e7:	c7 04 24 81 12 10 00 	movl   $0x101281,(%esp)
  1012ee:	e8 43 ff ff ff       	call   101236 <cons_intr>
    }
}
  1012f3:	c9                   	leave  
  1012f4:	c3                   	ret    

001012f5 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  1012f5:	55                   	push   %ebp
  1012f6:	89 e5                	mov    %esp,%ebp
  1012f8:	83 ec 38             	sub    $0x38,%esp
  1012fb:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101301:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  101305:	89 c2                	mov    %eax,%edx
  101307:	ec                   	in     (%dx),%al
  101308:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  10130b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  10130f:	0f b6 c0             	movzbl %al,%eax
  101312:	83 e0 01             	and    $0x1,%eax
  101315:	85 c0                	test   %eax,%eax
  101317:	75 0a                	jne    101323 <kbd_proc_data+0x2e>
        return -1;
  101319:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10131e:	e9 59 01 00 00       	jmp    10147c <kbd_proc_data+0x187>
  101323:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101329:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10132d:	89 c2                	mov    %eax,%edx
  10132f:	ec                   	in     (%dx),%al
  101330:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  101333:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  101337:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  10133a:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  10133e:	75 17                	jne    101357 <kbd_proc_data+0x62>
        // E0 escape character
        shift |= E0ESC;
  101340:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101345:	83 c8 40             	or     $0x40,%eax
  101348:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  10134d:	b8 00 00 00 00       	mov    $0x0,%eax
  101352:	e9 25 01 00 00       	jmp    10147c <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  101357:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10135b:	84 c0                	test   %al,%al
  10135d:	79 47                	jns    1013a6 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  10135f:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101364:	83 e0 40             	and    $0x40,%eax
  101367:	85 c0                	test   %eax,%eax
  101369:	75 09                	jne    101374 <kbd_proc_data+0x7f>
  10136b:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10136f:	83 e0 7f             	and    $0x7f,%eax
  101372:	eb 04                	jmp    101378 <kbd_proc_data+0x83>
  101374:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101378:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  10137b:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10137f:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  101386:	83 c8 40             	or     $0x40,%eax
  101389:	0f b6 c0             	movzbl %al,%eax
  10138c:	f7 d0                	not    %eax
  10138e:	89 c2                	mov    %eax,%edx
  101390:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101395:	21 d0                	and    %edx,%eax
  101397:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  10139c:	b8 00 00 00 00       	mov    $0x0,%eax
  1013a1:	e9 d6 00 00 00       	jmp    10147c <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  1013a6:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013ab:	83 e0 40             	and    $0x40,%eax
  1013ae:	85 c0                	test   %eax,%eax
  1013b0:	74 11                	je     1013c3 <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  1013b2:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  1013b6:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013bb:	83 e0 bf             	and    $0xffffffbf,%eax
  1013be:	a3 88 f0 10 00       	mov    %eax,0x10f088
    }

    shift |= shiftcode[data];
  1013c3:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1013c7:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  1013ce:	0f b6 d0             	movzbl %al,%edx
  1013d1:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013d6:	09 d0                	or     %edx,%eax
  1013d8:	a3 88 f0 10 00       	mov    %eax,0x10f088
    shift ^= togglecode[data];
  1013dd:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1013e1:	0f b6 80 40 e1 10 00 	movzbl 0x10e140(%eax),%eax
  1013e8:	0f b6 d0             	movzbl %al,%edx
  1013eb:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013f0:	31 d0                	xor    %edx,%eax
  1013f2:	a3 88 f0 10 00       	mov    %eax,0x10f088

    c = charcode[shift & (CTL | SHIFT)][data];
  1013f7:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013fc:	83 e0 03             	and    $0x3,%eax
  1013ff:	8b 14 85 40 e5 10 00 	mov    0x10e540(,%eax,4),%edx
  101406:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10140a:	01 d0                	add    %edx,%eax
  10140c:	0f b6 00             	movzbl (%eax),%eax
  10140f:	0f b6 c0             	movzbl %al,%eax
  101412:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  101415:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10141a:	83 e0 08             	and    $0x8,%eax
  10141d:	85 c0                	test   %eax,%eax
  10141f:	74 22                	je     101443 <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  101421:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  101425:	7e 0c                	jle    101433 <kbd_proc_data+0x13e>
  101427:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  10142b:	7f 06                	jg     101433 <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  10142d:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  101431:	eb 10                	jmp    101443 <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  101433:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  101437:	7e 0a                	jle    101443 <kbd_proc_data+0x14e>
  101439:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  10143d:	7f 04                	jg     101443 <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  10143f:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  101443:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101448:	f7 d0                	not    %eax
  10144a:	83 e0 06             	and    $0x6,%eax
  10144d:	85 c0                	test   %eax,%eax
  10144f:	75 28                	jne    101479 <kbd_proc_data+0x184>
  101451:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  101458:	75 1f                	jne    101479 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  10145a:	c7 04 24 75 36 10 00 	movl   $0x103675,(%esp)
  101461:	e8 ac ee ff ff       	call   100312 <cprintf>
  101466:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  10146c:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101470:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  101474:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  101478:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101479:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10147c:	c9                   	leave  
  10147d:	c3                   	ret    

0010147e <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  10147e:	55                   	push   %ebp
  10147f:	89 e5                	mov    %esp,%ebp
  101481:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  101484:	c7 04 24 f5 12 10 00 	movl   $0x1012f5,(%esp)
  10148b:	e8 a6 fd ff ff       	call   101236 <cons_intr>
}
  101490:	c9                   	leave  
  101491:	c3                   	ret    

00101492 <kbd_init>:

static void
kbd_init(void) {
  101492:	55                   	push   %ebp
  101493:	89 e5                	mov    %esp,%ebp
  101495:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  101498:	e8 e1 ff ff ff       	call   10147e <kbd_intr>
    pic_enable(IRQ_KBD);
  10149d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1014a4:	e8 17 01 00 00       	call   1015c0 <pic_enable>
}
  1014a9:	c9                   	leave  
  1014aa:	c3                   	ret    

001014ab <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  1014ab:	55                   	push   %ebp
  1014ac:	89 e5                	mov    %esp,%ebp
  1014ae:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  1014b1:	e8 93 f8 ff ff       	call   100d49 <cga_init>
    serial_init();
  1014b6:	e8 74 f9 ff ff       	call   100e2f <serial_init>
    kbd_init();
  1014bb:	e8 d2 ff ff ff       	call   101492 <kbd_init>
    if (!serial_exists) {
  1014c0:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  1014c5:	85 c0                	test   %eax,%eax
  1014c7:	75 0c                	jne    1014d5 <cons_init+0x2a>
        cprintf("serial port does not exist!!\n");
  1014c9:	c7 04 24 81 36 10 00 	movl   $0x103681,(%esp)
  1014d0:	e8 3d ee ff ff       	call   100312 <cprintf>
    }
}
  1014d5:	c9                   	leave  
  1014d6:	c3                   	ret    

001014d7 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  1014d7:	55                   	push   %ebp
  1014d8:	89 e5                	mov    %esp,%ebp
  1014da:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  1014dd:	8b 45 08             	mov    0x8(%ebp),%eax
  1014e0:	89 04 24             	mov    %eax,(%esp)
  1014e3:	e8 a3 fa ff ff       	call   100f8b <lpt_putc>
    cga_putc(c);
  1014e8:	8b 45 08             	mov    0x8(%ebp),%eax
  1014eb:	89 04 24             	mov    %eax,(%esp)
  1014ee:	e8 d7 fa ff ff       	call   100fca <cga_putc>
    serial_putc(c);
  1014f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1014f6:	89 04 24             	mov    %eax,(%esp)
  1014f9:	e8 f9 fc ff ff       	call   1011f7 <serial_putc>
}
  1014fe:	c9                   	leave  
  1014ff:	c3                   	ret    

00101500 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  101500:	55                   	push   %ebp
  101501:	89 e5                	mov    %esp,%ebp
  101503:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  101506:	e8 cd fd ff ff       	call   1012d8 <serial_intr>
    kbd_intr();
  10150b:	e8 6e ff ff ff       	call   10147e <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  101510:	8b 15 80 f0 10 00    	mov    0x10f080,%edx
  101516:	a1 84 f0 10 00       	mov    0x10f084,%eax
  10151b:	39 c2                	cmp    %eax,%edx
  10151d:	74 36                	je     101555 <cons_getc+0x55>
        c = cons.buf[cons.rpos ++];
  10151f:	a1 80 f0 10 00       	mov    0x10f080,%eax
  101524:	8d 50 01             	lea    0x1(%eax),%edx
  101527:	89 15 80 f0 10 00    	mov    %edx,0x10f080
  10152d:	0f b6 80 80 ee 10 00 	movzbl 0x10ee80(%eax),%eax
  101534:	0f b6 c0             	movzbl %al,%eax
  101537:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  10153a:	a1 80 f0 10 00       	mov    0x10f080,%eax
  10153f:	3d 00 02 00 00       	cmp    $0x200,%eax
  101544:	75 0a                	jne    101550 <cons_getc+0x50>
            cons.rpos = 0;
  101546:	c7 05 80 f0 10 00 00 	movl   $0x0,0x10f080
  10154d:	00 00 00 
        }
        return c;
  101550:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101553:	eb 05                	jmp    10155a <cons_getc+0x5a>
    }
    return 0;
  101555:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10155a:	c9                   	leave  
  10155b:	c3                   	ret    

0010155c <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  10155c:	55                   	push   %ebp
  10155d:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  10155f:	fb                   	sti    
    sti();
}
  101560:	5d                   	pop    %ebp
  101561:	c3                   	ret    

00101562 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  101562:	55                   	push   %ebp
  101563:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli");
  101565:	fa                   	cli    
    cli();
}
  101566:	5d                   	pop    %ebp
  101567:	c3                   	ret    

00101568 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101568:	55                   	push   %ebp
  101569:	89 e5                	mov    %esp,%ebp
  10156b:	83 ec 14             	sub    $0x14,%esp
  10156e:	8b 45 08             	mov    0x8(%ebp),%eax
  101571:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  101575:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101579:	66 a3 50 e5 10 00    	mov    %ax,0x10e550
    if (did_init) {
  10157f:	a1 8c f0 10 00       	mov    0x10f08c,%eax
  101584:	85 c0                	test   %eax,%eax
  101586:	74 36                	je     1015be <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
  101588:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10158c:	0f b6 c0             	movzbl %al,%eax
  10158f:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  101595:	88 45 fd             	mov    %al,-0x3(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101598:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  10159c:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1015a0:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  1015a1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1015a5:	66 c1 e8 08          	shr    $0x8,%ax
  1015a9:	0f b6 c0             	movzbl %al,%eax
  1015ac:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  1015b2:	88 45 f9             	mov    %al,-0x7(%ebp)
  1015b5:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1015b9:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1015bd:	ee                   	out    %al,(%dx)
    }
}
  1015be:	c9                   	leave  
  1015bf:	c3                   	ret    

001015c0 <pic_enable>:

void
pic_enable(unsigned int irq) {
  1015c0:	55                   	push   %ebp
  1015c1:	89 e5                	mov    %esp,%ebp
  1015c3:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  1015c6:	8b 45 08             	mov    0x8(%ebp),%eax
  1015c9:	ba 01 00 00 00       	mov    $0x1,%edx
  1015ce:	89 c1                	mov    %eax,%ecx
  1015d0:	d3 e2                	shl    %cl,%edx
  1015d2:	89 d0                	mov    %edx,%eax
  1015d4:	f7 d0                	not    %eax
  1015d6:	89 c2                	mov    %eax,%edx
  1015d8:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1015df:	21 d0                	and    %edx,%eax
  1015e1:	0f b7 c0             	movzwl %ax,%eax
  1015e4:	89 04 24             	mov    %eax,(%esp)
  1015e7:	e8 7c ff ff ff       	call   101568 <pic_setmask>
}
  1015ec:	c9                   	leave  
  1015ed:	c3                   	ret    

001015ee <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  1015ee:	55                   	push   %ebp
  1015ef:	89 e5                	mov    %esp,%ebp
  1015f1:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  1015f4:	c7 05 8c f0 10 00 01 	movl   $0x1,0x10f08c
  1015fb:	00 00 00 
  1015fe:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  101604:	c6 45 fd ff          	movb   $0xff,-0x3(%ebp)
  101608:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  10160c:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101610:	ee                   	out    %al,(%dx)
  101611:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  101617:	c6 45 f9 ff          	movb   $0xff,-0x7(%ebp)
  10161b:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10161f:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101623:	ee                   	out    %al,(%dx)
  101624:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  10162a:	c6 45 f5 11          	movb   $0x11,-0xb(%ebp)
  10162e:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101632:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101636:	ee                   	out    %al,(%dx)
  101637:	66 c7 45 f2 21 00    	movw   $0x21,-0xe(%ebp)
  10163d:	c6 45 f1 20          	movb   $0x20,-0xf(%ebp)
  101641:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101645:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101649:	ee                   	out    %al,(%dx)
  10164a:	66 c7 45 ee 21 00    	movw   $0x21,-0x12(%ebp)
  101650:	c6 45 ed 04          	movb   $0x4,-0x13(%ebp)
  101654:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101658:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10165c:	ee                   	out    %al,(%dx)
  10165d:	66 c7 45 ea 21 00    	movw   $0x21,-0x16(%ebp)
  101663:	c6 45 e9 03          	movb   $0x3,-0x17(%ebp)
  101667:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10166b:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10166f:	ee                   	out    %al,(%dx)
  101670:	66 c7 45 e6 a0 00    	movw   $0xa0,-0x1a(%ebp)
  101676:	c6 45 e5 11          	movb   $0x11,-0x1b(%ebp)
  10167a:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10167e:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101682:	ee                   	out    %al,(%dx)
  101683:	66 c7 45 e2 a1 00    	movw   $0xa1,-0x1e(%ebp)
  101689:	c6 45 e1 28          	movb   $0x28,-0x1f(%ebp)
  10168d:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101691:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101695:	ee                   	out    %al,(%dx)
  101696:	66 c7 45 de a1 00    	movw   $0xa1,-0x22(%ebp)
  10169c:	c6 45 dd 02          	movb   $0x2,-0x23(%ebp)
  1016a0:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  1016a4:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  1016a8:	ee                   	out    %al,(%dx)
  1016a9:	66 c7 45 da a1 00    	movw   $0xa1,-0x26(%ebp)
  1016af:	c6 45 d9 03          	movb   $0x3,-0x27(%ebp)
  1016b3:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  1016b7:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  1016bb:	ee                   	out    %al,(%dx)
  1016bc:	66 c7 45 d6 20 00    	movw   $0x20,-0x2a(%ebp)
  1016c2:	c6 45 d5 68          	movb   $0x68,-0x2b(%ebp)
  1016c6:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1016ca:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1016ce:	ee                   	out    %al,(%dx)
  1016cf:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1016d5:	c6 45 d1 0a          	movb   $0xa,-0x2f(%ebp)
  1016d9:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1016dd:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1016e1:	ee                   	out    %al,(%dx)
  1016e2:	66 c7 45 ce a0 00    	movw   $0xa0,-0x32(%ebp)
  1016e8:	c6 45 cd 68          	movb   $0x68,-0x33(%ebp)
  1016ec:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1016f0:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1016f4:	ee                   	out    %al,(%dx)
  1016f5:	66 c7 45 ca a0 00    	movw   $0xa0,-0x36(%ebp)
  1016fb:	c6 45 c9 0a          	movb   $0xa,-0x37(%ebp)
  1016ff:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  101703:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  101707:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  101708:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  10170f:	66 83 f8 ff          	cmp    $0xffff,%ax
  101713:	74 12                	je     101727 <pic_init+0x139>
        pic_setmask(irq_mask);
  101715:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  10171c:	0f b7 c0             	movzwl %ax,%eax
  10171f:	89 04 24             	mov    %eax,(%esp)
  101722:	e8 41 fe ff ff       	call   101568 <pic_setmask>
    }
}
  101727:	c9                   	leave  
  101728:	c3                   	ret    

00101729 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  101729:	55                   	push   %ebp
  10172a:	89 e5                	mov    %esp,%ebp
  10172c:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  10172f:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  101736:	00 
  101737:	c7 04 24 a0 36 10 00 	movl   $0x1036a0,(%esp)
  10173e:	e8 cf eb ff ff       	call   100312 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  101743:	c9                   	leave  
  101744:	c3                   	ret    

00101745 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101745:	55                   	push   %ebp
  101746:	89 e5                	mov    %esp,%ebp
  101748:	83 ec 10             	sub    $0x10,%esp
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  10174b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101752:	e9 c3 00 00 00       	jmp    10181a <idt_init+0xd5>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  101757:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10175a:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  101761:	89 c2                	mov    %eax,%edx
  101763:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101766:	66 89 14 c5 a0 f0 10 	mov    %dx,0x10f0a0(,%eax,8)
  10176d:	00 
  10176e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101771:	66 c7 04 c5 a2 f0 10 	movw   $0x8,0x10f0a2(,%eax,8)
  101778:	00 08 00 
  10177b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10177e:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  101785:	00 
  101786:	83 e2 e0             	and    $0xffffffe0,%edx
  101789:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  101790:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101793:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  10179a:	00 
  10179b:	83 e2 1f             	and    $0x1f,%edx
  10179e:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  1017a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1017a8:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1017af:	00 
  1017b0:	83 e2 f0             	and    $0xfffffff0,%edx
  1017b3:	83 ca 0e             	or     $0xe,%edx
  1017b6:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1017bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1017c0:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1017c7:	00 
  1017c8:	83 e2 ef             	and    $0xffffffef,%edx
  1017cb:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1017d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1017d5:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1017dc:	00 
  1017dd:	83 e2 9f             	and    $0xffffff9f,%edx
  1017e0:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1017e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1017ea:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1017f1:	00 
  1017f2:	83 ca 80             	or     $0xffffff80,%edx
  1017f5:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1017fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1017ff:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  101806:	c1 e8 10             	shr    $0x10,%eax
  101809:	89 c2                	mov    %eax,%edx
  10180b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10180e:	66 89 14 c5 a6 f0 10 	mov    %dx,0x10f0a6(,%eax,8)
  101815:	00 
/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101816:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10181a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10181d:	3d ff 00 00 00       	cmp    $0xff,%eax
  101822:	0f 86 2f ff ff ff    	jbe    101757 <idt_init+0x12>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
    }
	// set for switch from user to kernel
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  101828:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  10182d:	66 a3 68 f4 10 00    	mov    %ax,0x10f468
  101833:	66 c7 05 6a f4 10 00 	movw   $0x8,0x10f46a
  10183a:	08 00 
  10183c:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  101843:	83 e0 e0             	and    $0xffffffe0,%eax
  101846:	a2 6c f4 10 00       	mov    %al,0x10f46c
  10184b:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  101852:	83 e0 1f             	and    $0x1f,%eax
  101855:	a2 6c f4 10 00       	mov    %al,0x10f46c
  10185a:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101861:	83 e0 f0             	and    $0xfffffff0,%eax
  101864:	83 c8 0e             	or     $0xe,%eax
  101867:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10186c:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101873:	83 e0 ef             	and    $0xffffffef,%eax
  101876:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10187b:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101882:	83 c8 60             	or     $0x60,%eax
  101885:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10188a:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101891:	83 c8 80             	or     $0xffffff80,%eax
  101894:	a2 6d f4 10 00       	mov    %al,0x10f46d
  101899:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  10189e:	c1 e8 10             	shr    $0x10,%eax
  1018a1:	66 a3 6e f4 10 00    	mov    %ax,0x10f46e
  1018a7:	c7 45 f8 60 e5 10 00 	movl   $0x10e560,-0x8(%ebp)
    return ebp;
}

static inline void
lidt(struct pseudodesc *pd) {
    asm volatile ("lidt (%0)" :: "r" (pd));
  1018ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1018b1:	0f 01 18             	lidtl  (%eax)
	// load the IDT
    lidt(&idt_pd);
}
  1018b4:	c9                   	leave  
  1018b5:	c3                   	ret    

001018b6 <trapname>:

static const char *
trapname(int trapno) {
  1018b6:	55                   	push   %ebp
  1018b7:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  1018b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1018bc:	83 f8 13             	cmp    $0x13,%eax
  1018bf:	77 0c                	ja     1018cd <trapname+0x17>
        return excnames[trapno];
  1018c1:	8b 45 08             	mov    0x8(%ebp),%eax
  1018c4:	8b 04 85 00 3a 10 00 	mov    0x103a00(,%eax,4),%eax
  1018cb:	eb 18                	jmp    1018e5 <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  1018cd:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  1018d1:	7e 0d                	jle    1018e0 <trapname+0x2a>
  1018d3:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  1018d7:	7f 07                	jg     1018e0 <trapname+0x2a>
        return "Hardware Interrupt";
  1018d9:	b8 aa 36 10 00       	mov    $0x1036aa,%eax
  1018de:	eb 05                	jmp    1018e5 <trapname+0x2f>
    }
    return "(unknown trap)";
  1018e0:	b8 bd 36 10 00       	mov    $0x1036bd,%eax
}
  1018e5:	5d                   	pop    %ebp
  1018e6:	c3                   	ret    

001018e7 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  1018e7:	55                   	push   %ebp
  1018e8:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  1018ea:	8b 45 08             	mov    0x8(%ebp),%eax
  1018ed:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  1018f1:	66 83 f8 08          	cmp    $0x8,%ax
  1018f5:	0f 94 c0             	sete   %al
  1018f8:	0f b6 c0             	movzbl %al,%eax
}
  1018fb:	5d                   	pop    %ebp
  1018fc:	c3                   	ret    

001018fd <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  1018fd:	55                   	push   %ebp
  1018fe:	89 e5                	mov    %esp,%ebp
  101900:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101903:	8b 45 08             	mov    0x8(%ebp),%eax
  101906:	89 44 24 04          	mov    %eax,0x4(%esp)
  10190a:	c7 04 24 fe 36 10 00 	movl   $0x1036fe,(%esp)
  101911:	e8 fc e9 ff ff       	call   100312 <cprintf>
    print_regs(&tf->tf_regs);
  101916:	8b 45 08             	mov    0x8(%ebp),%eax
  101919:	89 04 24             	mov    %eax,(%esp)
  10191c:	e8 a1 01 00 00       	call   101ac2 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101921:	8b 45 08             	mov    0x8(%ebp),%eax
  101924:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101928:	0f b7 c0             	movzwl %ax,%eax
  10192b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10192f:	c7 04 24 0f 37 10 00 	movl   $0x10370f,(%esp)
  101936:	e8 d7 e9 ff ff       	call   100312 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  10193b:	8b 45 08             	mov    0x8(%ebp),%eax
  10193e:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101942:	0f b7 c0             	movzwl %ax,%eax
  101945:	89 44 24 04          	mov    %eax,0x4(%esp)
  101949:	c7 04 24 22 37 10 00 	movl   $0x103722,(%esp)
  101950:	e8 bd e9 ff ff       	call   100312 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101955:	8b 45 08             	mov    0x8(%ebp),%eax
  101958:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  10195c:	0f b7 c0             	movzwl %ax,%eax
  10195f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101963:	c7 04 24 35 37 10 00 	movl   $0x103735,(%esp)
  10196a:	e8 a3 e9 ff ff       	call   100312 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  10196f:	8b 45 08             	mov    0x8(%ebp),%eax
  101972:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101976:	0f b7 c0             	movzwl %ax,%eax
  101979:	89 44 24 04          	mov    %eax,0x4(%esp)
  10197d:	c7 04 24 48 37 10 00 	movl   $0x103748,(%esp)
  101984:	e8 89 e9 ff ff       	call   100312 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101989:	8b 45 08             	mov    0x8(%ebp),%eax
  10198c:	8b 40 30             	mov    0x30(%eax),%eax
  10198f:	89 04 24             	mov    %eax,(%esp)
  101992:	e8 1f ff ff ff       	call   1018b6 <trapname>
  101997:	8b 55 08             	mov    0x8(%ebp),%edx
  10199a:	8b 52 30             	mov    0x30(%edx),%edx
  10199d:	89 44 24 08          	mov    %eax,0x8(%esp)
  1019a1:	89 54 24 04          	mov    %edx,0x4(%esp)
  1019a5:	c7 04 24 5b 37 10 00 	movl   $0x10375b,(%esp)
  1019ac:	e8 61 e9 ff ff       	call   100312 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  1019b1:	8b 45 08             	mov    0x8(%ebp),%eax
  1019b4:	8b 40 34             	mov    0x34(%eax),%eax
  1019b7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019bb:	c7 04 24 6d 37 10 00 	movl   $0x10376d,(%esp)
  1019c2:	e8 4b e9 ff ff       	call   100312 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  1019c7:	8b 45 08             	mov    0x8(%ebp),%eax
  1019ca:	8b 40 38             	mov    0x38(%eax),%eax
  1019cd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019d1:	c7 04 24 7c 37 10 00 	movl   $0x10377c,(%esp)
  1019d8:	e8 35 e9 ff ff       	call   100312 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  1019dd:	8b 45 08             	mov    0x8(%ebp),%eax
  1019e0:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  1019e4:	0f b7 c0             	movzwl %ax,%eax
  1019e7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019eb:	c7 04 24 8b 37 10 00 	movl   $0x10378b,(%esp)
  1019f2:	e8 1b e9 ff ff       	call   100312 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  1019f7:	8b 45 08             	mov    0x8(%ebp),%eax
  1019fa:	8b 40 40             	mov    0x40(%eax),%eax
  1019fd:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a01:	c7 04 24 9e 37 10 00 	movl   $0x10379e,(%esp)
  101a08:	e8 05 e9 ff ff       	call   100312 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101a0d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101a14:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101a1b:	eb 3e                	jmp    101a5b <print_trapframe+0x15e>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  101a20:	8b 50 40             	mov    0x40(%eax),%edx
  101a23:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101a26:	21 d0                	and    %edx,%eax
  101a28:	85 c0                	test   %eax,%eax
  101a2a:	74 28                	je     101a54 <print_trapframe+0x157>
  101a2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101a2f:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101a36:	85 c0                	test   %eax,%eax
  101a38:	74 1a                	je     101a54 <print_trapframe+0x157>
            cprintf("%s,", IA32flags[i]);
  101a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101a3d:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101a44:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a48:	c7 04 24 ad 37 10 00 	movl   $0x1037ad,(%esp)
  101a4f:	e8 be e8 ff ff       	call   100312 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
    cprintf("  flag 0x%08x ", tf->tf_eflags);

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101a54:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101a58:	d1 65 f0             	shll   -0x10(%ebp)
  101a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101a5e:	83 f8 17             	cmp    $0x17,%eax
  101a61:	76 ba                	jbe    101a1d <print_trapframe+0x120>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
            cprintf("%s,", IA32flags[i]);
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101a63:	8b 45 08             	mov    0x8(%ebp),%eax
  101a66:	8b 40 40             	mov    0x40(%eax),%eax
  101a69:	25 00 30 00 00       	and    $0x3000,%eax
  101a6e:	c1 e8 0c             	shr    $0xc,%eax
  101a71:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a75:	c7 04 24 b1 37 10 00 	movl   $0x1037b1,(%esp)
  101a7c:	e8 91 e8 ff ff       	call   100312 <cprintf>

    if (!trap_in_kernel(tf)) {
  101a81:	8b 45 08             	mov    0x8(%ebp),%eax
  101a84:	89 04 24             	mov    %eax,(%esp)
  101a87:	e8 5b fe ff ff       	call   1018e7 <trap_in_kernel>
  101a8c:	85 c0                	test   %eax,%eax
  101a8e:	75 30                	jne    101ac0 <print_trapframe+0x1c3>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101a90:	8b 45 08             	mov    0x8(%ebp),%eax
  101a93:	8b 40 44             	mov    0x44(%eax),%eax
  101a96:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a9a:	c7 04 24 ba 37 10 00 	movl   $0x1037ba,(%esp)
  101aa1:	e8 6c e8 ff ff       	call   100312 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  101aa9:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101aad:	0f b7 c0             	movzwl %ax,%eax
  101ab0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ab4:	c7 04 24 c9 37 10 00 	movl   $0x1037c9,(%esp)
  101abb:	e8 52 e8 ff ff       	call   100312 <cprintf>
    }
}
  101ac0:	c9                   	leave  
  101ac1:	c3                   	ret    

00101ac2 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101ac2:	55                   	push   %ebp
  101ac3:	89 e5                	mov    %esp,%ebp
  101ac5:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101ac8:	8b 45 08             	mov    0x8(%ebp),%eax
  101acb:	8b 00                	mov    (%eax),%eax
  101acd:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ad1:	c7 04 24 dc 37 10 00 	movl   $0x1037dc,(%esp)
  101ad8:	e8 35 e8 ff ff       	call   100312 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101add:	8b 45 08             	mov    0x8(%ebp),%eax
  101ae0:	8b 40 04             	mov    0x4(%eax),%eax
  101ae3:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ae7:	c7 04 24 eb 37 10 00 	movl   $0x1037eb,(%esp)
  101aee:	e8 1f e8 ff ff       	call   100312 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101af3:	8b 45 08             	mov    0x8(%ebp),%eax
  101af6:	8b 40 08             	mov    0x8(%eax),%eax
  101af9:	89 44 24 04          	mov    %eax,0x4(%esp)
  101afd:	c7 04 24 fa 37 10 00 	movl   $0x1037fa,(%esp)
  101b04:	e8 09 e8 ff ff       	call   100312 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101b09:	8b 45 08             	mov    0x8(%ebp),%eax
  101b0c:	8b 40 0c             	mov    0xc(%eax),%eax
  101b0f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b13:	c7 04 24 09 38 10 00 	movl   $0x103809,(%esp)
  101b1a:	e8 f3 e7 ff ff       	call   100312 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  101b22:	8b 40 10             	mov    0x10(%eax),%eax
  101b25:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b29:	c7 04 24 18 38 10 00 	movl   $0x103818,(%esp)
  101b30:	e8 dd e7 ff ff       	call   100312 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101b35:	8b 45 08             	mov    0x8(%ebp),%eax
  101b38:	8b 40 14             	mov    0x14(%eax),%eax
  101b3b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b3f:	c7 04 24 27 38 10 00 	movl   $0x103827,(%esp)
  101b46:	e8 c7 e7 ff ff       	call   100312 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  101b4e:	8b 40 18             	mov    0x18(%eax),%eax
  101b51:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b55:	c7 04 24 36 38 10 00 	movl   $0x103836,(%esp)
  101b5c:	e8 b1 e7 ff ff       	call   100312 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101b61:	8b 45 08             	mov    0x8(%ebp),%eax
  101b64:	8b 40 1c             	mov    0x1c(%eax),%eax
  101b67:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b6b:	c7 04 24 45 38 10 00 	movl   $0x103845,(%esp)
  101b72:	e8 9b e7 ff ff       	call   100312 <cprintf>
}
  101b77:	c9                   	leave  
  101b78:	c3                   	ret    

00101b79 <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101b79:	55                   	push   %ebp
  101b7a:	89 e5                	mov    %esp,%ebp
  101b7c:	83 ec 28             	sub    $0x28,%esp
    char c;

    switch (tf->tf_trapno) {
  101b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  101b82:	8b 40 30             	mov    0x30(%eax),%eax
  101b85:	83 f8 2f             	cmp    $0x2f,%eax
  101b88:	77 1e                	ja     101ba8 <trap_dispatch+0x2f>
  101b8a:	83 f8 2e             	cmp    $0x2e,%eax
  101b8d:	0f 83 bf 00 00 00    	jae    101c52 <trap_dispatch+0xd9>
  101b93:	83 f8 21             	cmp    $0x21,%eax
  101b96:	74 40                	je     101bd8 <trap_dispatch+0x5f>
  101b98:	83 f8 24             	cmp    $0x24,%eax
  101b9b:	74 15                	je     101bb2 <trap_dispatch+0x39>
  101b9d:	83 f8 20             	cmp    $0x20,%eax
  101ba0:	0f 84 af 00 00 00    	je     101c55 <trap_dispatch+0xdc>
  101ba6:	eb 72                	jmp    101c1a <trap_dispatch+0xa1>
  101ba8:	83 e8 78             	sub    $0x78,%eax
  101bab:	83 f8 01             	cmp    $0x1,%eax
  101bae:	77 6a                	ja     101c1a <trap_dispatch+0xa1>
  101bb0:	eb 4c                	jmp    101bfe <trap_dispatch+0x85>
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        break;
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101bb2:	e8 49 f9 ff ff       	call   101500 <cons_getc>
  101bb7:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101bba:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101bbe:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101bc2:	89 54 24 08          	mov    %edx,0x8(%esp)
  101bc6:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bca:	c7 04 24 54 38 10 00 	movl   $0x103854,(%esp)
  101bd1:	e8 3c e7 ff ff       	call   100312 <cprintf>
        break;
  101bd6:	eb 7e                	jmp    101c56 <trap_dispatch+0xdd>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101bd8:	e8 23 f9 ff ff       	call   101500 <cons_getc>
  101bdd:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101be0:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101be4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101be8:	89 54 24 08          	mov    %edx,0x8(%esp)
  101bec:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bf0:	c7 04 24 66 38 10 00 	movl   $0x103866,(%esp)
  101bf7:	e8 16 e7 ff ff       	call   100312 <cprintf>
        break;
  101bfc:	eb 58                	jmp    101c56 <trap_dispatch+0xdd>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
  101bfe:	c7 44 24 08 75 38 10 	movl   $0x103875,0x8(%esp)
  101c05:	00 
  101c06:	c7 44 24 04 9f 00 00 	movl   $0x9f,0x4(%esp)
  101c0d:	00 
  101c0e:	c7 04 24 85 38 10 00 	movl   $0x103885,(%esp)
  101c15:	e8 c8 ef ff ff       	call   100be2 <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  101c1d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101c21:	0f b7 c0             	movzwl %ax,%eax
  101c24:	83 e0 03             	and    $0x3,%eax
  101c27:	85 c0                	test   %eax,%eax
  101c29:	75 2b                	jne    101c56 <trap_dispatch+0xdd>
            print_trapframe(tf);
  101c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  101c2e:	89 04 24             	mov    %eax,(%esp)
  101c31:	e8 c7 fc ff ff       	call   1018fd <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101c36:	c7 44 24 08 96 38 10 	movl   $0x103896,0x8(%esp)
  101c3d:	00 
  101c3e:	c7 44 24 04 a9 00 00 	movl   $0xa9,0x4(%esp)
  101c45:	00 
  101c46:	c7 04 24 85 38 10 00 	movl   $0x103885,(%esp)
  101c4d:	e8 90 ef ff ff       	call   100be2 <__panic>
        panic("T_SWITCH_** ??\n");
        break;
    case IRQ_OFFSET + IRQ_IDE1:
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
  101c52:	90                   	nop
  101c53:	eb 01                	jmp    101c56 <trap_dispatch+0xdd>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        break;
  101c55:	90                   	nop
        if ((tf->tf_cs & 3) == 0) {
            print_trapframe(tf);
            panic("unexpected trap in kernel.\n");
        }
    }
}
  101c56:	c9                   	leave  
  101c57:	c3                   	ret    

00101c58 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101c58:	55                   	push   %ebp
  101c59:	89 e5                	mov    %esp,%ebp
  101c5b:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  101c61:	89 04 24             	mov    %eax,(%esp)
  101c64:	e8 10 ff ff ff       	call   101b79 <trap_dispatch>
}
  101c69:	c9                   	leave  
  101c6a:	c3                   	ret    

00101c6b <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  101c6b:	1e                   	push   %ds
    pushl %es
  101c6c:	06                   	push   %es
    pushl %fs
  101c6d:	0f a0                	push   %fs
    pushl %gs
  101c6f:	0f a8                	push   %gs
    pushal
  101c71:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  101c72:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  101c77:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  101c79:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  101c7b:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  101c7c:	e8 d7 ff ff ff       	call   101c58 <trap>

    # pop the pushed stack pointer
    popl %esp
  101c81:	5c                   	pop    %esp

00101c82 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  101c82:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  101c83:	0f a9                	pop    %gs
    popl %fs
  101c85:	0f a1                	pop    %fs
    popl %es
  101c87:	07                   	pop    %es
    popl %ds
  101c88:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  101c89:	83 c4 08             	add    $0x8,%esp
    iret
  101c8c:	cf                   	iret   

00101c8d <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101c8d:	6a 00                	push   $0x0
  pushl $0
  101c8f:	6a 00                	push   $0x0
  jmp __alltraps
  101c91:	e9 d5 ff ff ff       	jmp    101c6b <__alltraps>

00101c96 <vector1>:
.globl vector1
vector1:
  pushl $0
  101c96:	6a 00                	push   $0x0
  pushl $1
  101c98:	6a 01                	push   $0x1
  jmp __alltraps
  101c9a:	e9 cc ff ff ff       	jmp    101c6b <__alltraps>

00101c9f <vector2>:
.globl vector2
vector2:
  pushl $0
  101c9f:	6a 00                	push   $0x0
  pushl $2
  101ca1:	6a 02                	push   $0x2
  jmp __alltraps
  101ca3:	e9 c3 ff ff ff       	jmp    101c6b <__alltraps>

00101ca8 <vector3>:
.globl vector3
vector3:
  pushl $0
  101ca8:	6a 00                	push   $0x0
  pushl $3
  101caa:	6a 03                	push   $0x3
  jmp __alltraps
  101cac:	e9 ba ff ff ff       	jmp    101c6b <__alltraps>

00101cb1 <vector4>:
.globl vector4
vector4:
  pushl $0
  101cb1:	6a 00                	push   $0x0
  pushl $4
  101cb3:	6a 04                	push   $0x4
  jmp __alltraps
  101cb5:	e9 b1 ff ff ff       	jmp    101c6b <__alltraps>

00101cba <vector5>:
.globl vector5
vector5:
  pushl $0
  101cba:	6a 00                	push   $0x0
  pushl $5
  101cbc:	6a 05                	push   $0x5
  jmp __alltraps
  101cbe:	e9 a8 ff ff ff       	jmp    101c6b <__alltraps>

00101cc3 <vector6>:
.globl vector6
vector6:
  pushl $0
  101cc3:	6a 00                	push   $0x0
  pushl $6
  101cc5:	6a 06                	push   $0x6
  jmp __alltraps
  101cc7:	e9 9f ff ff ff       	jmp    101c6b <__alltraps>

00101ccc <vector7>:
.globl vector7
vector7:
  pushl $0
  101ccc:	6a 00                	push   $0x0
  pushl $7
  101cce:	6a 07                	push   $0x7
  jmp __alltraps
  101cd0:	e9 96 ff ff ff       	jmp    101c6b <__alltraps>

00101cd5 <vector8>:
.globl vector8
vector8:
  pushl $8
  101cd5:	6a 08                	push   $0x8
  jmp __alltraps
  101cd7:	e9 8f ff ff ff       	jmp    101c6b <__alltraps>

00101cdc <vector9>:
.globl vector9
vector9:
  pushl $9
  101cdc:	6a 09                	push   $0x9
  jmp __alltraps
  101cde:	e9 88 ff ff ff       	jmp    101c6b <__alltraps>

00101ce3 <vector10>:
.globl vector10
vector10:
  pushl $10
  101ce3:	6a 0a                	push   $0xa
  jmp __alltraps
  101ce5:	e9 81 ff ff ff       	jmp    101c6b <__alltraps>

00101cea <vector11>:
.globl vector11
vector11:
  pushl $11
  101cea:	6a 0b                	push   $0xb
  jmp __alltraps
  101cec:	e9 7a ff ff ff       	jmp    101c6b <__alltraps>

00101cf1 <vector12>:
.globl vector12
vector12:
  pushl $12
  101cf1:	6a 0c                	push   $0xc
  jmp __alltraps
  101cf3:	e9 73 ff ff ff       	jmp    101c6b <__alltraps>

00101cf8 <vector13>:
.globl vector13
vector13:
  pushl $13
  101cf8:	6a 0d                	push   $0xd
  jmp __alltraps
  101cfa:	e9 6c ff ff ff       	jmp    101c6b <__alltraps>

00101cff <vector14>:
.globl vector14
vector14:
  pushl $14
  101cff:	6a 0e                	push   $0xe
  jmp __alltraps
  101d01:	e9 65 ff ff ff       	jmp    101c6b <__alltraps>

00101d06 <vector15>:
.globl vector15
vector15:
  pushl $0
  101d06:	6a 00                	push   $0x0
  pushl $15
  101d08:	6a 0f                	push   $0xf
  jmp __alltraps
  101d0a:	e9 5c ff ff ff       	jmp    101c6b <__alltraps>

00101d0f <vector16>:
.globl vector16
vector16:
  pushl $0
  101d0f:	6a 00                	push   $0x0
  pushl $16
  101d11:	6a 10                	push   $0x10
  jmp __alltraps
  101d13:	e9 53 ff ff ff       	jmp    101c6b <__alltraps>

00101d18 <vector17>:
.globl vector17
vector17:
  pushl $17
  101d18:	6a 11                	push   $0x11
  jmp __alltraps
  101d1a:	e9 4c ff ff ff       	jmp    101c6b <__alltraps>

00101d1f <vector18>:
.globl vector18
vector18:
  pushl $0
  101d1f:	6a 00                	push   $0x0
  pushl $18
  101d21:	6a 12                	push   $0x12
  jmp __alltraps
  101d23:	e9 43 ff ff ff       	jmp    101c6b <__alltraps>

00101d28 <vector19>:
.globl vector19
vector19:
  pushl $0
  101d28:	6a 00                	push   $0x0
  pushl $19
  101d2a:	6a 13                	push   $0x13
  jmp __alltraps
  101d2c:	e9 3a ff ff ff       	jmp    101c6b <__alltraps>

00101d31 <vector20>:
.globl vector20
vector20:
  pushl $0
  101d31:	6a 00                	push   $0x0
  pushl $20
  101d33:	6a 14                	push   $0x14
  jmp __alltraps
  101d35:	e9 31 ff ff ff       	jmp    101c6b <__alltraps>

00101d3a <vector21>:
.globl vector21
vector21:
  pushl $0
  101d3a:	6a 00                	push   $0x0
  pushl $21
  101d3c:	6a 15                	push   $0x15
  jmp __alltraps
  101d3e:	e9 28 ff ff ff       	jmp    101c6b <__alltraps>

00101d43 <vector22>:
.globl vector22
vector22:
  pushl $0
  101d43:	6a 00                	push   $0x0
  pushl $22
  101d45:	6a 16                	push   $0x16
  jmp __alltraps
  101d47:	e9 1f ff ff ff       	jmp    101c6b <__alltraps>

00101d4c <vector23>:
.globl vector23
vector23:
  pushl $0
  101d4c:	6a 00                	push   $0x0
  pushl $23
  101d4e:	6a 17                	push   $0x17
  jmp __alltraps
  101d50:	e9 16 ff ff ff       	jmp    101c6b <__alltraps>

00101d55 <vector24>:
.globl vector24
vector24:
  pushl $0
  101d55:	6a 00                	push   $0x0
  pushl $24
  101d57:	6a 18                	push   $0x18
  jmp __alltraps
  101d59:	e9 0d ff ff ff       	jmp    101c6b <__alltraps>

00101d5e <vector25>:
.globl vector25
vector25:
  pushl $0
  101d5e:	6a 00                	push   $0x0
  pushl $25
  101d60:	6a 19                	push   $0x19
  jmp __alltraps
  101d62:	e9 04 ff ff ff       	jmp    101c6b <__alltraps>

00101d67 <vector26>:
.globl vector26
vector26:
  pushl $0
  101d67:	6a 00                	push   $0x0
  pushl $26
  101d69:	6a 1a                	push   $0x1a
  jmp __alltraps
  101d6b:	e9 fb fe ff ff       	jmp    101c6b <__alltraps>

00101d70 <vector27>:
.globl vector27
vector27:
  pushl $0
  101d70:	6a 00                	push   $0x0
  pushl $27
  101d72:	6a 1b                	push   $0x1b
  jmp __alltraps
  101d74:	e9 f2 fe ff ff       	jmp    101c6b <__alltraps>

00101d79 <vector28>:
.globl vector28
vector28:
  pushl $0
  101d79:	6a 00                	push   $0x0
  pushl $28
  101d7b:	6a 1c                	push   $0x1c
  jmp __alltraps
  101d7d:	e9 e9 fe ff ff       	jmp    101c6b <__alltraps>

00101d82 <vector29>:
.globl vector29
vector29:
  pushl $0
  101d82:	6a 00                	push   $0x0
  pushl $29
  101d84:	6a 1d                	push   $0x1d
  jmp __alltraps
  101d86:	e9 e0 fe ff ff       	jmp    101c6b <__alltraps>

00101d8b <vector30>:
.globl vector30
vector30:
  pushl $0
  101d8b:	6a 00                	push   $0x0
  pushl $30
  101d8d:	6a 1e                	push   $0x1e
  jmp __alltraps
  101d8f:	e9 d7 fe ff ff       	jmp    101c6b <__alltraps>

00101d94 <vector31>:
.globl vector31
vector31:
  pushl $0
  101d94:	6a 00                	push   $0x0
  pushl $31
  101d96:	6a 1f                	push   $0x1f
  jmp __alltraps
  101d98:	e9 ce fe ff ff       	jmp    101c6b <__alltraps>

00101d9d <vector32>:
.globl vector32
vector32:
  pushl $0
  101d9d:	6a 00                	push   $0x0
  pushl $32
  101d9f:	6a 20                	push   $0x20
  jmp __alltraps
  101da1:	e9 c5 fe ff ff       	jmp    101c6b <__alltraps>

00101da6 <vector33>:
.globl vector33
vector33:
  pushl $0
  101da6:	6a 00                	push   $0x0
  pushl $33
  101da8:	6a 21                	push   $0x21
  jmp __alltraps
  101daa:	e9 bc fe ff ff       	jmp    101c6b <__alltraps>

00101daf <vector34>:
.globl vector34
vector34:
  pushl $0
  101daf:	6a 00                	push   $0x0
  pushl $34
  101db1:	6a 22                	push   $0x22
  jmp __alltraps
  101db3:	e9 b3 fe ff ff       	jmp    101c6b <__alltraps>

00101db8 <vector35>:
.globl vector35
vector35:
  pushl $0
  101db8:	6a 00                	push   $0x0
  pushl $35
  101dba:	6a 23                	push   $0x23
  jmp __alltraps
  101dbc:	e9 aa fe ff ff       	jmp    101c6b <__alltraps>

00101dc1 <vector36>:
.globl vector36
vector36:
  pushl $0
  101dc1:	6a 00                	push   $0x0
  pushl $36
  101dc3:	6a 24                	push   $0x24
  jmp __alltraps
  101dc5:	e9 a1 fe ff ff       	jmp    101c6b <__alltraps>

00101dca <vector37>:
.globl vector37
vector37:
  pushl $0
  101dca:	6a 00                	push   $0x0
  pushl $37
  101dcc:	6a 25                	push   $0x25
  jmp __alltraps
  101dce:	e9 98 fe ff ff       	jmp    101c6b <__alltraps>

00101dd3 <vector38>:
.globl vector38
vector38:
  pushl $0
  101dd3:	6a 00                	push   $0x0
  pushl $38
  101dd5:	6a 26                	push   $0x26
  jmp __alltraps
  101dd7:	e9 8f fe ff ff       	jmp    101c6b <__alltraps>

00101ddc <vector39>:
.globl vector39
vector39:
  pushl $0
  101ddc:	6a 00                	push   $0x0
  pushl $39
  101dde:	6a 27                	push   $0x27
  jmp __alltraps
  101de0:	e9 86 fe ff ff       	jmp    101c6b <__alltraps>

00101de5 <vector40>:
.globl vector40
vector40:
  pushl $0
  101de5:	6a 00                	push   $0x0
  pushl $40
  101de7:	6a 28                	push   $0x28
  jmp __alltraps
  101de9:	e9 7d fe ff ff       	jmp    101c6b <__alltraps>

00101dee <vector41>:
.globl vector41
vector41:
  pushl $0
  101dee:	6a 00                	push   $0x0
  pushl $41
  101df0:	6a 29                	push   $0x29
  jmp __alltraps
  101df2:	e9 74 fe ff ff       	jmp    101c6b <__alltraps>

00101df7 <vector42>:
.globl vector42
vector42:
  pushl $0
  101df7:	6a 00                	push   $0x0
  pushl $42
  101df9:	6a 2a                	push   $0x2a
  jmp __alltraps
  101dfb:	e9 6b fe ff ff       	jmp    101c6b <__alltraps>

00101e00 <vector43>:
.globl vector43
vector43:
  pushl $0
  101e00:	6a 00                	push   $0x0
  pushl $43
  101e02:	6a 2b                	push   $0x2b
  jmp __alltraps
  101e04:	e9 62 fe ff ff       	jmp    101c6b <__alltraps>

00101e09 <vector44>:
.globl vector44
vector44:
  pushl $0
  101e09:	6a 00                	push   $0x0
  pushl $44
  101e0b:	6a 2c                	push   $0x2c
  jmp __alltraps
  101e0d:	e9 59 fe ff ff       	jmp    101c6b <__alltraps>

00101e12 <vector45>:
.globl vector45
vector45:
  pushl $0
  101e12:	6a 00                	push   $0x0
  pushl $45
  101e14:	6a 2d                	push   $0x2d
  jmp __alltraps
  101e16:	e9 50 fe ff ff       	jmp    101c6b <__alltraps>

00101e1b <vector46>:
.globl vector46
vector46:
  pushl $0
  101e1b:	6a 00                	push   $0x0
  pushl $46
  101e1d:	6a 2e                	push   $0x2e
  jmp __alltraps
  101e1f:	e9 47 fe ff ff       	jmp    101c6b <__alltraps>

00101e24 <vector47>:
.globl vector47
vector47:
  pushl $0
  101e24:	6a 00                	push   $0x0
  pushl $47
  101e26:	6a 2f                	push   $0x2f
  jmp __alltraps
  101e28:	e9 3e fe ff ff       	jmp    101c6b <__alltraps>

00101e2d <vector48>:
.globl vector48
vector48:
  pushl $0
  101e2d:	6a 00                	push   $0x0
  pushl $48
  101e2f:	6a 30                	push   $0x30
  jmp __alltraps
  101e31:	e9 35 fe ff ff       	jmp    101c6b <__alltraps>

00101e36 <vector49>:
.globl vector49
vector49:
  pushl $0
  101e36:	6a 00                	push   $0x0
  pushl $49
  101e38:	6a 31                	push   $0x31
  jmp __alltraps
  101e3a:	e9 2c fe ff ff       	jmp    101c6b <__alltraps>

00101e3f <vector50>:
.globl vector50
vector50:
  pushl $0
  101e3f:	6a 00                	push   $0x0
  pushl $50
  101e41:	6a 32                	push   $0x32
  jmp __alltraps
  101e43:	e9 23 fe ff ff       	jmp    101c6b <__alltraps>

00101e48 <vector51>:
.globl vector51
vector51:
  pushl $0
  101e48:	6a 00                	push   $0x0
  pushl $51
  101e4a:	6a 33                	push   $0x33
  jmp __alltraps
  101e4c:	e9 1a fe ff ff       	jmp    101c6b <__alltraps>

00101e51 <vector52>:
.globl vector52
vector52:
  pushl $0
  101e51:	6a 00                	push   $0x0
  pushl $52
  101e53:	6a 34                	push   $0x34
  jmp __alltraps
  101e55:	e9 11 fe ff ff       	jmp    101c6b <__alltraps>

00101e5a <vector53>:
.globl vector53
vector53:
  pushl $0
  101e5a:	6a 00                	push   $0x0
  pushl $53
  101e5c:	6a 35                	push   $0x35
  jmp __alltraps
  101e5e:	e9 08 fe ff ff       	jmp    101c6b <__alltraps>

00101e63 <vector54>:
.globl vector54
vector54:
  pushl $0
  101e63:	6a 00                	push   $0x0
  pushl $54
  101e65:	6a 36                	push   $0x36
  jmp __alltraps
  101e67:	e9 ff fd ff ff       	jmp    101c6b <__alltraps>

00101e6c <vector55>:
.globl vector55
vector55:
  pushl $0
  101e6c:	6a 00                	push   $0x0
  pushl $55
  101e6e:	6a 37                	push   $0x37
  jmp __alltraps
  101e70:	e9 f6 fd ff ff       	jmp    101c6b <__alltraps>

00101e75 <vector56>:
.globl vector56
vector56:
  pushl $0
  101e75:	6a 00                	push   $0x0
  pushl $56
  101e77:	6a 38                	push   $0x38
  jmp __alltraps
  101e79:	e9 ed fd ff ff       	jmp    101c6b <__alltraps>

00101e7e <vector57>:
.globl vector57
vector57:
  pushl $0
  101e7e:	6a 00                	push   $0x0
  pushl $57
  101e80:	6a 39                	push   $0x39
  jmp __alltraps
  101e82:	e9 e4 fd ff ff       	jmp    101c6b <__alltraps>

00101e87 <vector58>:
.globl vector58
vector58:
  pushl $0
  101e87:	6a 00                	push   $0x0
  pushl $58
  101e89:	6a 3a                	push   $0x3a
  jmp __alltraps
  101e8b:	e9 db fd ff ff       	jmp    101c6b <__alltraps>

00101e90 <vector59>:
.globl vector59
vector59:
  pushl $0
  101e90:	6a 00                	push   $0x0
  pushl $59
  101e92:	6a 3b                	push   $0x3b
  jmp __alltraps
  101e94:	e9 d2 fd ff ff       	jmp    101c6b <__alltraps>

00101e99 <vector60>:
.globl vector60
vector60:
  pushl $0
  101e99:	6a 00                	push   $0x0
  pushl $60
  101e9b:	6a 3c                	push   $0x3c
  jmp __alltraps
  101e9d:	e9 c9 fd ff ff       	jmp    101c6b <__alltraps>

00101ea2 <vector61>:
.globl vector61
vector61:
  pushl $0
  101ea2:	6a 00                	push   $0x0
  pushl $61
  101ea4:	6a 3d                	push   $0x3d
  jmp __alltraps
  101ea6:	e9 c0 fd ff ff       	jmp    101c6b <__alltraps>

00101eab <vector62>:
.globl vector62
vector62:
  pushl $0
  101eab:	6a 00                	push   $0x0
  pushl $62
  101ead:	6a 3e                	push   $0x3e
  jmp __alltraps
  101eaf:	e9 b7 fd ff ff       	jmp    101c6b <__alltraps>

00101eb4 <vector63>:
.globl vector63
vector63:
  pushl $0
  101eb4:	6a 00                	push   $0x0
  pushl $63
  101eb6:	6a 3f                	push   $0x3f
  jmp __alltraps
  101eb8:	e9 ae fd ff ff       	jmp    101c6b <__alltraps>

00101ebd <vector64>:
.globl vector64
vector64:
  pushl $0
  101ebd:	6a 00                	push   $0x0
  pushl $64
  101ebf:	6a 40                	push   $0x40
  jmp __alltraps
  101ec1:	e9 a5 fd ff ff       	jmp    101c6b <__alltraps>

00101ec6 <vector65>:
.globl vector65
vector65:
  pushl $0
  101ec6:	6a 00                	push   $0x0
  pushl $65
  101ec8:	6a 41                	push   $0x41
  jmp __alltraps
  101eca:	e9 9c fd ff ff       	jmp    101c6b <__alltraps>

00101ecf <vector66>:
.globl vector66
vector66:
  pushl $0
  101ecf:	6a 00                	push   $0x0
  pushl $66
  101ed1:	6a 42                	push   $0x42
  jmp __alltraps
  101ed3:	e9 93 fd ff ff       	jmp    101c6b <__alltraps>

00101ed8 <vector67>:
.globl vector67
vector67:
  pushl $0
  101ed8:	6a 00                	push   $0x0
  pushl $67
  101eda:	6a 43                	push   $0x43
  jmp __alltraps
  101edc:	e9 8a fd ff ff       	jmp    101c6b <__alltraps>

00101ee1 <vector68>:
.globl vector68
vector68:
  pushl $0
  101ee1:	6a 00                	push   $0x0
  pushl $68
  101ee3:	6a 44                	push   $0x44
  jmp __alltraps
  101ee5:	e9 81 fd ff ff       	jmp    101c6b <__alltraps>

00101eea <vector69>:
.globl vector69
vector69:
  pushl $0
  101eea:	6a 00                	push   $0x0
  pushl $69
  101eec:	6a 45                	push   $0x45
  jmp __alltraps
  101eee:	e9 78 fd ff ff       	jmp    101c6b <__alltraps>

00101ef3 <vector70>:
.globl vector70
vector70:
  pushl $0
  101ef3:	6a 00                	push   $0x0
  pushl $70
  101ef5:	6a 46                	push   $0x46
  jmp __alltraps
  101ef7:	e9 6f fd ff ff       	jmp    101c6b <__alltraps>

00101efc <vector71>:
.globl vector71
vector71:
  pushl $0
  101efc:	6a 00                	push   $0x0
  pushl $71
  101efe:	6a 47                	push   $0x47
  jmp __alltraps
  101f00:	e9 66 fd ff ff       	jmp    101c6b <__alltraps>

00101f05 <vector72>:
.globl vector72
vector72:
  pushl $0
  101f05:	6a 00                	push   $0x0
  pushl $72
  101f07:	6a 48                	push   $0x48
  jmp __alltraps
  101f09:	e9 5d fd ff ff       	jmp    101c6b <__alltraps>

00101f0e <vector73>:
.globl vector73
vector73:
  pushl $0
  101f0e:	6a 00                	push   $0x0
  pushl $73
  101f10:	6a 49                	push   $0x49
  jmp __alltraps
  101f12:	e9 54 fd ff ff       	jmp    101c6b <__alltraps>

00101f17 <vector74>:
.globl vector74
vector74:
  pushl $0
  101f17:	6a 00                	push   $0x0
  pushl $74
  101f19:	6a 4a                	push   $0x4a
  jmp __alltraps
  101f1b:	e9 4b fd ff ff       	jmp    101c6b <__alltraps>

00101f20 <vector75>:
.globl vector75
vector75:
  pushl $0
  101f20:	6a 00                	push   $0x0
  pushl $75
  101f22:	6a 4b                	push   $0x4b
  jmp __alltraps
  101f24:	e9 42 fd ff ff       	jmp    101c6b <__alltraps>

00101f29 <vector76>:
.globl vector76
vector76:
  pushl $0
  101f29:	6a 00                	push   $0x0
  pushl $76
  101f2b:	6a 4c                	push   $0x4c
  jmp __alltraps
  101f2d:	e9 39 fd ff ff       	jmp    101c6b <__alltraps>

00101f32 <vector77>:
.globl vector77
vector77:
  pushl $0
  101f32:	6a 00                	push   $0x0
  pushl $77
  101f34:	6a 4d                	push   $0x4d
  jmp __alltraps
  101f36:	e9 30 fd ff ff       	jmp    101c6b <__alltraps>

00101f3b <vector78>:
.globl vector78
vector78:
  pushl $0
  101f3b:	6a 00                	push   $0x0
  pushl $78
  101f3d:	6a 4e                	push   $0x4e
  jmp __alltraps
  101f3f:	e9 27 fd ff ff       	jmp    101c6b <__alltraps>

00101f44 <vector79>:
.globl vector79
vector79:
  pushl $0
  101f44:	6a 00                	push   $0x0
  pushl $79
  101f46:	6a 4f                	push   $0x4f
  jmp __alltraps
  101f48:	e9 1e fd ff ff       	jmp    101c6b <__alltraps>

00101f4d <vector80>:
.globl vector80
vector80:
  pushl $0
  101f4d:	6a 00                	push   $0x0
  pushl $80
  101f4f:	6a 50                	push   $0x50
  jmp __alltraps
  101f51:	e9 15 fd ff ff       	jmp    101c6b <__alltraps>

00101f56 <vector81>:
.globl vector81
vector81:
  pushl $0
  101f56:	6a 00                	push   $0x0
  pushl $81
  101f58:	6a 51                	push   $0x51
  jmp __alltraps
  101f5a:	e9 0c fd ff ff       	jmp    101c6b <__alltraps>

00101f5f <vector82>:
.globl vector82
vector82:
  pushl $0
  101f5f:	6a 00                	push   $0x0
  pushl $82
  101f61:	6a 52                	push   $0x52
  jmp __alltraps
  101f63:	e9 03 fd ff ff       	jmp    101c6b <__alltraps>

00101f68 <vector83>:
.globl vector83
vector83:
  pushl $0
  101f68:	6a 00                	push   $0x0
  pushl $83
  101f6a:	6a 53                	push   $0x53
  jmp __alltraps
  101f6c:	e9 fa fc ff ff       	jmp    101c6b <__alltraps>

00101f71 <vector84>:
.globl vector84
vector84:
  pushl $0
  101f71:	6a 00                	push   $0x0
  pushl $84
  101f73:	6a 54                	push   $0x54
  jmp __alltraps
  101f75:	e9 f1 fc ff ff       	jmp    101c6b <__alltraps>

00101f7a <vector85>:
.globl vector85
vector85:
  pushl $0
  101f7a:	6a 00                	push   $0x0
  pushl $85
  101f7c:	6a 55                	push   $0x55
  jmp __alltraps
  101f7e:	e9 e8 fc ff ff       	jmp    101c6b <__alltraps>

00101f83 <vector86>:
.globl vector86
vector86:
  pushl $0
  101f83:	6a 00                	push   $0x0
  pushl $86
  101f85:	6a 56                	push   $0x56
  jmp __alltraps
  101f87:	e9 df fc ff ff       	jmp    101c6b <__alltraps>

00101f8c <vector87>:
.globl vector87
vector87:
  pushl $0
  101f8c:	6a 00                	push   $0x0
  pushl $87
  101f8e:	6a 57                	push   $0x57
  jmp __alltraps
  101f90:	e9 d6 fc ff ff       	jmp    101c6b <__alltraps>

00101f95 <vector88>:
.globl vector88
vector88:
  pushl $0
  101f95:	6a 00                	push   $0x0
  pushl $88
  101f97:	6a 58                	push   $0x58
  jmp __alltraps
  101f99:	e9 cd fc ff ff       	jmp    101c6b <__alltraps>

00101f9e <vector89>:
.globl vector89
vector89:
  pushl $0
  101f9e:	6a 00                	push   $0x0
  pushl $89
  101fa0:	6a 59                	push   $0x59
  jmp __alltraps
  101fa2:	e9 c4 fc ff ff       	jmp    101c6b <__alltraps>

00101fa7 <vector90>:
.globl vector90
vector90:
  pushl $0
  101fa7:	6a 00                	push   $0x0
  pushl $90
  101fa9:	6a 5a                	push   $0x5a
  jmp __alltraps
  101fab:	e9 bb fc ff ff       	jmp    101c6b <__alltraps>

00101fb0 <vector91>:
.globl vector91
vector91:
  pushl $0
  101fb0:	6a 00                	push   $0x0
  pushl $91
  101fb2:	6a 5b                	push   $0x5b
  jmp __alltraps
  101fb4:	e9 b2 fc ff ff       	jmp    101c6b <__alltraps>

00101fb9 <vector92>:
.globl vector92
vector92:
  pushl $0
  101fb9:	6a 00                	push   $0x0
  pushl $92
  101fbb:	6a 5c                	push   $0x5c
  jmp __alltraps
  101fbd:	e9 a9 fc ff ff       	jmp    101c6b <__alltraps>

00101fc2 <vector93>:
.globl vector93
vector93:
  pushl $0
  101fc2:	6a 00                	push   $0x0
  pushl $93
  101fc4:	6a 5d                	push   $0x5d
  jmp __alltraps
  101fc6:	e9 a0 fc ff ff       	jmp    101c6b <__alltraps>

00101fcb <vector94>:
.globl vector94
vector94:
  pushl $0
  101fcb:	6a 00                	push   $0x0
  pushl $94
  101fcd:	6a 5e                	push   $0x5e
  jmp __alltraps
  101fcf:	e9 97 fc ff ff       	jmp    101c6b <__alltraps>

00101fd4 <vector95>:
.globl vector95
vector95:
  pushl $0
  101fd4:	6a 00                	push   $0x0
  pushl $95
  101fd6:	6a 5f                	push   $0x5f
  jmp __alltraps
  101fd8:	e9 8e fc ff ff       	jmp    101c6b <__alltraps>

00101fdd <vector96>:
.globl vector96
vector96:
  pushl $0
  101fdd:	6a 00                	push   $0x0
  pushl $96
  101fdf:	6a 60                	push   $0x60
  jmp __alltraps
  101fe1:	e9 85 fc ff ff       	jmp    101c6b <__alltraps>

00101fe6 <vector97>:
.globl vector97
vector97:
  pushl $0
  101fe6:	6a 00                	push   $0x0
  pushl $97
  101fe8:	6a 61                	push   $0x61
  jmp __alltraps
  101fea:	e9 7c fc ff ff       	jmp    101c6b <__alltraps>

00101fef <vector98>:
.globl vector98
vector98:
  pushl $0
  101fef:	6a 00                	push   $0x0
  pushl $98
  101ff1:	6a 62                	push   $0x62
  jmp __alltraps
  101ff3:	e9 73 fc ff ff       	jmp    101c6b <__alltraps>

00101ff8 <vector99>:
.globl vector99
vector99:
  pushl $0
  101ff8:	6a 00                	push   $0x0
  pushl $99
  101ffa:	6a 63                	push   $0x63
  jmp __alltraps
  101ffc:	e9 6a fc ff ff       	jmp    101c6b <__alltraps>

00102001 <vector100>:
.globl vector100
vector100:
  pushl $0
  102001:	6a 00                	push   $0x0
  pushl $100
  102003:	6a 64                	push   $0x64
  jmp __alltraps
  102005:	e9 61 fc ff ff       	jmp    101c6b <__alltraps>

0010200a <vector101>:
.globl vector101
vector101:
  pushl $0
  10200a:	6a 00                	push   $0x0
  pushl $101
  10200c:	6a 65                	push   $0x65
  jmp __alltraps
  10200e:	e9 58 fc ff ff       	jmp    101c6b <__alltraps>

00102013 <vector102>:
.globl vector102
vector102:
  pushl $0
  102013:	6a 00                	push   $0x0
  pushl $102
  102015:	6a 66                	push   $0x66
  jmp __alltraps
  102017:	e9 4f fc ff ff       	jmp    101c6b <__alltraps>

0010201c <vector103>:
.globl vector103
vector103:
  pushl $0
  10201c:	6a 00                	push   $0x0
  pushl $103
  10201e:	6a 67                	push   $0x67
  jmp __alltraps
  102020:	e9 46 fc ff ff       	jmp    101c6b <__alltraps>

00102025 <vector104>:
.globl vector104
vector104:
  pushl $0
  102025:	6a 00                	push   $0x0
  pushl $104
  102027:	6a 68                	push   $0x68
  jmp __alltraps
  102029:	e9 3d fc ff ff       	jmp    101c6b <__alltraps>

0010202e <vector105>:
.globl vector105
vector105:
  pushl $0
  10202e:	6a 00                	push   $0x0
  pushl $105
  102030:	6a 69                	push   $0x69
  jmp __alltraps
  102032:	e9 34 fc ff ff       	jmp    101c6b <__alltraps>

00102037 <vector106>:
.globl vector106
vector106:
  pushl $0
  102037:	6a 00                	push   $0x0
  pushl $106
  102039:	6a 6a                	push   $0x6a
  jmp __alltraps
  10203b:	e9 2b fc ff ff       	jmp    101c6b <__alltraps>

00102040 <vector107>:
.globl vector107
vector107:
  pushl $0
  102040:	6a 00                	push   $0x0
  pushl $107
  102042:	6a 6b                	push   $0x6b
  jmp __alltraps
  102044:	e9 22 fc ff ff       	jmp    101c6b <__alltraps>

00102049 <vector108>:
.globl vector108
vector108:
  pushl $0
  102049:	6a 00                	push   $0x0
  pushl $108
  10204b:	6a 6c                	push   $0x6c
  jmp __alltraps
  10204d:	e9 19 fc ff ff       	jmp    101c6b <__alltraps>

00102052 <vector109>:
.globl vector109
vector109:
  pushl $0
  102052:	6a 00                	push   $0x0
  pushl $109
  102054:	6a 6d                	push   $0x6d
  jmp __alltraps
  102056:	e9 10 fc ff ff       	jmp    101c6b <__alltraps>

0010205b <vector110>:
.globl vector110
vector110:
  pushl $0
  10205b:	6a 00                	push   $0x0
  pushl $110
  10205d:	6a 6e                	push   $0x6e
  jmp __alltraps
  10205f:	e9 07 fc ff ff       	jmp    101c6b <__alltraps>

00102064 <vector111>:
.globl vector111
vector111:
  pushl $0
  102064:	6a 00                	push   $0x0
  pushl $111
  102066:	6a 6f                	push   $0x6f
  jmp __alltraps
  102068:	e9 fe fb ff ff       	jmp    101c6b <__alltraps>

0010206d <vector112>:
.globl vector112
vector112:
  pushl $0
  10206d:	6a 00                	push   $0x0
  pushl $112
  10206f:	6a 70                	push   $0x70
  jmp __alltraps
  102071:	e9 f5 fb ff ff       	jmp    101c6b <__alltraps>

00102076 <vector113>:
.globl vector113
vector113:
  pushl $0
  102076:	6a 00                	push   $0x0
  pushl $113
  102078:	6a 71                	push   $0x71
  jmp __alltraps
  10207a:	e9 ec fb ff ff       	jmp    101c6b <__alltraps>

0010207f <vector114>:
.globl vector114
vector114:
  pushl $0
  10207f:	6a 00                	push   $0x0
  pushl $114
  102081:	6a 72                	push   $0x72
  jmp __alltraps
  102083:	e9 e3 fb ff ff       	jmp    101c6b <__alltraps>

00102088 <vector115>:
.globl vector115
vector115:
  pushl $0
  102088:	6a 00                	push   $0x0
  pushl $115
  10208a:	6a 73                	push   $0x73
  jmp __alltraps
  10208c:	e9 da fb ff ff       	jmp    101c6b <__alltraps>

00102091 <vector116>:
.globl vector116
vector116:
  pushl $0
  102091:	6a 00                	push   $0x0
  pushl $116
  102093:	6a 74                	push   $0x74
  jmp __alltraps
  102095:	e9 d1 fb ff ff       	jmp    101c6b <__alltraps>

0010209a <vector117>:
.globl vector117
vector117:
  pushl $0
  10209a:	6a 00                	push   $0x0
  pushl $117
  10209c:	6a 75                	push   $0x75
  jmp __alltraps
  10209e:	e9 c8 fb ff ff       	jmp    101c6b <__alltraps>

001020a3 <vector118>:
.globl vector118
vector118:
  pushl $0
  1020a3:	6a 00                	push   $0x0
  pushl $118
  1020a5:	6a 76                	push   $0x76
  jmp __alltraps
  1020a7:	e9 bf fb ff ff       	jmp    101c6b <__alltraps>

001020ac <vector119>:
.globl vector119
vector119:
  pushl $0
  1020ac:	6a 00                	push   $0x0
  pushl $119
  1020ae:	6a 77                	push   $0x77
  jmp __alltraps
  1020b0:	e9 b6 fb ff ff       	jmp    101c6b <__alltraps>

001020b5 <vector120>:
.globl vector120
vector120:
  pushl $0
  1020b5:	6a 00                	push   $0x0
  pushl $120
  1020b7:	6a 78                	push   $0x78
  jmp __alltraps
  1020b9:	e9 ad fb ff ff       	jmp    101c6b <__alltraps>

001020be <vector121>:
.globl vector121
vector121:
  pushl $0
  1020be:	6a 00                	push   $0x0
  pushl $121
  1020c0:	6a 79                	push   $0x79
  jmp __alltraps
  1020c2:	e9 a4 fb ff ff       	jmp    101c6b <__alltraps>

001020c7 <vector122>:
.globl vector122
vector122:
  pushl $0
  1020c7:	6a 00                	push   $0x0
  pushl $122
  1020c9:	6a 7a                	push   $0x7a
  jmp __alltraps
  1020cb:	e9 9b fb ff ff       	jmp    101c6b <__alltraps>

001020d0 <vector123>:
.globl vector123
vector123:
  pushl $0
  1020d0:	6a 00                	push   $0x0
  pushl $123
  1020d2:	6a 7b                	push   $0x7b
  jmp __alltraps
  1020d4:	e9 92 fb ff ff       	jmp    101c6b <__alltraps>

001020d9 <vector124>:
.globl vector124
vector124:
  pushl $0
  1020d9:	6a 00                	push   $0x0
  pushl $124
  1020db:	6a 7c                	push   $0x7c
  jmp __alltraps
  1020dd:	e9 89 fb ff ff       	jmp    101c6b <__alltraps>

001020e2 <vector125>:
.globl vector125
vector125:
  pushl $0
  1020e2:	6a 00                	push   $0x0
  pushl $125
  1020e4:	6a 7d                	push   $0x7d
  jmp __alltraps
  1020e6:	e9 80 fb ff ff       	jmp    101c6b <__alltraps>

001020eb <vector126>:
.globl vector126
vector126:
  pushl $0
  1020eb:	6a 00                	push   $0x0
  pushl $126
  1020ed:	6a 7e                	push   $0x7e
  jmp __alltraps
  1020ef:	e9 77 fb ff ff       	jmp    101c6b <__alltraps>

001020f4 <vector127>:
.globl vector127
vector127:
  pushl $0
  1020f4:	6a 00                	push   $0x0
  pushl $127
  1020f6:	6a 7f                	push   $0x7f
  jmp __alltraps
  1020f8:	e9 6e fb ff ff       	jmp    101c6b <__alltraps>

001020fd <vector128>:
.globl vector128
vector128:
  pushl $0
  1020fd:	6a 00                	push   $0x0
  pushl $128
  1020ff:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  102104:	e9 62 fb ff ff       	jmp    101c6b <__alltraps>

00102109 <vector129>:
.globl vector129
vector129:
  pushl $0
  102109:	6a 00                	push   $0x0
  pushl $129
  10210b:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102110:	e9 56 fb ff ff       	jmp    101c6b <__alltraps>

00102115 <vector130>:
.globl vector130
vector130:
  pushl $0
  102115:	6a 00                	push   $0x0
  pushl $130
  102117:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  10211c:	e9 4a fb ff ff       	jmp    101c6b <__alltraps>

00102121 <vector131>:
.globl vector131
vector131:
  pushl $0
  102121:	6a 00                	push   $0x0
  pushl $131
  102123:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102128:	e9 3e fb ff ff       	jmp    101c6b <__alltraps>

0010212d <vector132>:
.globl vector132
vector132:
  pushl $0
  10212d:	6a 00                	push   $0x0
  pushl $132
  10212f:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102134:	e9 32 fb ff ff       	jmp    101c6b <__alltraps>

00102139 <vector133>:
.globl vector133
vector133:
  pushl $0
  102139:	6a 00                	push   $0x0
  pushl $133
  10213b:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  102140:	e9 26 fb ff ff       	jmp    101c6b <__alltraps>

00102145 <vector134>:
.globl vector134
vector134:
  pushl $0
  102145:	6a 00                	push   $0x0
  pushl $134
  102147:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  10214c:	e9 1a fb ff ff       	jmp    101c6b <__alltraps>

00102151 <vector135>:
.globl vector135
vector135:
  pushl $0
  102151:	6a 00                	push   $0x0
  pushl $135
  102153:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102158:	e9 0e fb ff ff       	jmp    101c6b <__alltraps>

0010215d <vector136>:
.globl vector136
vector136:
  pushl $0
  10215d:	6a 00                	push   $0x0
  pushl $136
  10215f:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102164:	e9 02 fb ff ff       	jmp    101c6b <__alltraps>

00102169 <vector137>:
.globl vector137
vector137:
  pushl $0
  102169:	6a 00                	push   $0x0
  pushl $137
  10216b:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  102170:	e9 f6 fa ff ff       	jmp    101c6b <__alltraps>

00102175 <vector138>:
.globl vector138
vector138:
  pushl $0
  102175:	6a 00                	push   $0x0
  pushl $138
  102177:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  10217c:	e9 ea fa ff ff       	jmp    101c6b <__alltraps>

00102181 <vector139>:
.globl vector139
vector139:
  pushl $0
  102181:	6a 00                	push   $0x0
  pushl $139
  102183:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102188:	e9 de fa ff ff       	jmp    101c6b <__alltraps>

0010218d <vector140>:
.globl vector140
vector140:
  pushl $0
  10218d:	6a 00                	push   $0x0
  pushl $140
  10218f:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  102194:	e9 d2 fa ff ff       	jmp    101c6b <__alltraps>

00102199 <vector141>:
.globl vector141
vector141:
  pushl $0
  102199:	6a 00                	push   $0x0
  pushl $141
  10219b:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1021a0:	e9 c6 fa ff ff       	jmp    101c6b <__alltraps>

001021a5 <vector142>:
.globl vector142
vector142:
  pushl $0
  1021a5:	6a 00                	push   $0x0
  pushl $142
  1021a7:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1021ac:	e9 ba fa ff ff       	jmp    101c6b <__alltraps>

001021b1 <vector143>:
.globl vector143
vector143:
  pushl $0
  1021b1:	6a 00                	push   $0x0
  pushl $143
  1021b3:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  1021b8:	e9 ae fa ff ff       	jmp    101c6b <__alltraps>

001021bd <vector144>:
.globl vector144
vector144:
  pushl $0
  1021bd:	6a 00                	push   $0x0
  pushl $144
  1021bf:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  1021c4:	e9 a2 fa ff ff       	jmp    101c6b <__alltraps>

001021c9 <vector145>:
.globl vector145
vector145:
  pushl $0
  1021c9:	6a 00                	push   $0x0
  pushl $145
  1021cb:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  1021d0:	e9 96 fa ff ff       	jmp    101c6b <__alltraps>

001021d5 <vector146>:
.globl vector146
vector146:
  pushl $0
  1021d5:	6a 00                	push   $0x0
  pushl $146
  1021d7:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1021dc:	e9 8a fa ff ff       	jmp    101c6b <__alltraps>

001021e1 <vector147>:
.globl vector147
vector147:
  pushl $0
  1021e1:	6a 00                	push   $0x0
  pushl $147
  1021e3:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1021e8:	e9 7e fa ff ff       	jmp    101c6b <__alltraps>

001021ed <vector148>:
.globl vector148
vector148:
  pushl $0
  1021ed:	6a 00                	push   $0x0
  pushl $148
  1021ef:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  1021f4:	e9 72 fa ff ff       	jmp    101c6b <__alltraps>

001021f9 <vector149>:
.globl vector149
vector149:
  pushl $0
  1021f9:	6a 00                	push   $0x0
  pushl $149
  1021fb:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102200:	e9 66 fa ff ff       	jmp    101c6b <__alltraps>

00102205 <vector150>:
.globl vector150
vector150:
  pushl $0
  102205:	6a 00                	push   $0x0
  pushl $150
  102207:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  10220c:	e9 5a fa ff ff       	jmp    101c6b <__alltraps>

00102211 <vector151>:
.globl vector151
vector151:
  pushl $0
  102211:	6a 00                	push   $0x0
  pushl $151
  102213:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102218:	e9 4e fa ff ff       	jmp    101c6b <__alltraps>

0010221d <vector152>:
.globl vector152
vector152:
  pushl $0
  10221d:	6a 00                	push   $0x0
  pushl $152
  10221f:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  102224:	e9 42 fa ff ff       	jmp    101c6b <__alltraps>

00102229 <vector153>:
.globl vector153
vector153:
  pushl $0
  102229:	6a 00                	push   $0x0
  pushl $153
  10222b:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  102230:	e9 36 fa ff ff       	jmp    101c6b <__alltraps>

00102235 <vector154>:
.globl vector154
vector154:
  pushl $0
  102235:	6a 00                	push   $0x0
  pushl $154
  102237:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  10223c:	e9 2a fa ff ff       	jmp    101c6b <__alltraps>

00102241 <vector155>:
.globl vector155
vector155:
  pushl $0
  102241:	6a 00                	push   $0x0
  pushl $155
  102243:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102248:	e9 1e fa ff ff       	jmp    101c6b <__alltraps>

0010224d <vector156>:
.globl vector156
vector156:
  pushl $0
  10224d:	6a 00                	push   $0x0
  pushl $156
  10224f:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102254:	e9 12 fa ff ff       	jmp    101c6b <__alltraps>

00102259 <vector157>:
.globl vector157
vector157:
  pushl $0
  102259:	6a 00                	push   $0x0
  pushl $157
  10225b:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  102260:	e9 06 fa ff ff       	jmp    101c6b <__alltraps>

00102265 <vector158>:
.globl vector158
vector158:
  pushl $0
  102265:	6a 00                	push   $0x0
  pushl $158
  102267:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  10226c:	e9 fa f9 ff ff       	jmp    101c6b <__alltraps>

00102271 <vector159>:
.globl vector159
vector159:
  pushl $0
  102271:	6a 00                	push   $0x0
  pushl $159
  102273:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102278:	e9 ee f9 ff ff       	jmp    101c6b <__alltraps>

0010227d <vector160>:
.globl vector160
vector160:
  pushl $0
  10227d:	6a 00                	push   $0x0
  pushl $160
  10227f:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102284:	e9 e2 f9 ff ff       	jmp    101c6b <__alltraps>

00102289 <vector161>:
.globl vector161
vector161:
  pushl $0
  102289:	6a 00                	push   $0x0
  pushl $161
  10228b:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  102290:	e9 d6 f9 ff ff       	jmp    101c6b <__alltraps>

00102295 <vector162>:
.globl vector162
vector162:
  pushl $0
  102295:	6a 00                	push   $0x0
  pushl $162
  102297:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  10229c:	e9 ca f9 ff ff       	jmp    101c6b <__alltraps>

001022a1 <vector163>:
.globl vector163
vector163:
  pushl $0
  1022a1:	6a 00                	push   $0x0
  pushl $163
  1022a3:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1022a8:	e9 be f9 ff ff       	jmp    101c6b <__alltraps>

001022ad <vector164>:
.globl vector164
vector164:
  pushl $0
  1022ad:	6a 00                	push   $0x0
  pushl $164
  1022af:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1022b4:	e9 b2 f9 ff ff       	jmp    101c6b <__alltraps>

001022b9 <vector165>:
.globl vector165
vector165:
  pushl $0
  1022b9:	6a 00                	push   $0x0
  pushl $165
  1022bb:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  1022c0:	e9 a6 f9 ff ff       	jmp    101c6b <__alltraps>

001022c5 <vector166>:
.globl vector166
vector166:
  pushl $0
  1022c5:	6a 00                	push   $0x0
  pushl $166
  1022c7:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  1022cc:	e9 9a f9 ff ff       	jmp    101c6b <__alltraps>

001022d1 <vector167>:
.globl vector167
vector167:
  pushl $0
  1022d1:	6a 00                	push   $0x0
  pushl $167
  1022d3:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1022d8:	e9 8e f9 ff ff       	jmp    101c6b <__alltraps>

001022dd <vector168>:
.globl vector168
vector168:
  pushl $0
  1022dd:	6a 00                	push   $0x0
  pushl $168
  1022df:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1022e4:	e9 82 f9 ff ff       	jmp    101c6b <__alltraps>

001022e9 <vector169>:
.globl vector169
vector169:
  pushl $0
  1022e9:	6a 00                	push   $0x0
  pushl $169
  1022eb:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  1022f0:	e9 76 f9 ff ff       	jmp    101c6b <__alltraps>

001022f5 <vector170>:
.globl vector170
vector170:
  pushl $0
  1022f5:	6a 00                	push   $0x0
  pushl $170
  1022f7:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  1022fc:	e9 6a f9 ff ff       	jmp    101c6b <__alltraps>

00102301 <vector171>:
.globl vector171
vector171:
  pushl $0
  102301:	6a 00                	push   $0x0
  pushl $171
  102303:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102308:	e9 5e f9 ff ff       	jmp    101c6b <__alltraps>

0010230d <vector172>:
.globl vector172
vector172:
  pushl $0
  10230d:	6a 00                	push   $0x0
  pushl $172
  10230f:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  102314:	e9 52 f9 ff ff       	jmp    101c6b <__alltraps>

00102319 <vector173>:
.globl vector173
vector173:
  pushl $0
  102319:	6a 00                	push   $0x0
  pushl $173
  10231b:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  102320:	e9 46 f9 ff ff       	jmp    101c6b <__alltraps>

00102325 <vector174>:
.globl vector174
vector174:
  pushl $0
  102325:	6a 00                	push   $0x0
  pushl $174
  102327:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  10232c:	e9 3a f9 ff ff       	jmp    101c6b <__alltraps>

00102331 <vector175>:
.globl vector175
vector175:
  pushl $0
  102331:	6a 00                	push   $0x0
  pushl $175
  102333:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102338:	e9 2e f9 ff ff       	jmp    101c6b <__alltraps>

0010233d <vector176>:
.globl vector176
vector176:
  pushl $0
  10233d:	6a 00                	push   $0x0
  pushl $176
  10233f:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102344:	e9 22 f9 ff ff       	jmp    101c6b <__alltraps>

00102349 <vector177>:
.globl vector177
vector177:
  pushl $0
  102349:	6a 00                	push   $0x0
  pushl $177
  10234b:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  102350:	e9 16 f9 ff ff       	jmp    101c6b <__alltraps>

00102355 <vector178>:
.globl vector178
vector178:
  pushl $0
  102355:	6a 00                	push   $0x0
  pushl $178
  102357:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  10235c:	e9 0a f9 ff ff       	jmp    101c6b <__alltraps>

00102361 <vector179>:
.globl vector179
vector179:
  pushl $0
  102361:	6a 00                	push   $0x0
  pushl $179
  102363:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  102368:	e9 fe f8 ff ff       	jmp    101c6b <__alltraps>

0010236d <vector180>:
.globl vector180
vector180:
  pushl $0
  10236d:	6a 00                	push   $0x0
  pushl $180
  10236f:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102374:	e9 f2 f8 ff ff       	jmp    101c6b <__alltraps>

00102379 <vector181>:
.globl vector181
vector181:
  pushl $0
  102379:	6a 00                	push   $0x0
  pushl $181
  10237b:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  102380:	e9 e6 f8 ff ff       	jmp    101c6b <__alltraps>

00102385 <vector182>:
.globl vector182
vector182:
  pushl $0
  102385:	6a 00                	push   $0x0
  pushl $182
  102387:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  10238c:	e9 da f8 ff ff       	jmp    101c6b <__alltraps>

00102391 <vector183>:
.globl vector183
vector183:
  pushl $0
  102391:	6a 00                	push   $0x0
  pushl $183
  102393:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102398:	e9 ce f8 ff ff       	jmp    101c6b <__alltraps>

0010239d <vector184>:
.globl vector184
vector184:
  pushl $0
  10239d:	6a 00                	push   $0x0
  pushl $184
  10239f:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1023a4:	e9 c2 f8 ff ff       	jmp    101c6b <__alltraps>

001023a9 <vector185>:
.globl vector185
vector185:
  pushl $0
  1023a9:	6a 00                	push   $0x0
  pushl $185
  1023ab:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1023b0:	e9 b6 f8 ff ff       	jmp    101c6b <__alltraps>

001023b5 <vector186>:
.globl vector186
vector186:
  pushl $0
  1023b5:	6a 00                	push   $0x0
  pushl $186
  1023b7:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  1023bc:	e9 aa f8 ff ff       	jmp    101c6b <__alltraps>

001023c1 <vector187>:
.globl vector187
vector187:
  pushl $0
  1023c1:	6a 00                	push   $0x0
  pushl $187
  1023c3:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  1023c8:	e9 9e f8 ff ff       	jmp    101c6b <__alltraps>

001023cd <vector188>:
.globl vector188
vector188:
  pushl $0
  1023cd:	6a 00                	push   $0x0
  pushl $188
  1023cf:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1023d4:	e9 92 f8 ff ff       	jmp    101c6b <__alltraps>

001023d9 <vector189>:
.globl vector189
vector189:
  pushl $0
  1023d9:	6a 00                	push   $0x0
  pushl $189
  1023db:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1023e0:	e9 86 f8 ff ff       	jmp    101c6b <__alltraps>

001023e5 <vector190>:
.globl vector190
vector190:
  pushl $0
  1023e5:	6a 00                	push   $0x0
  pushl $190
  1023e7:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1023ec:	e9 7a f8 ff ff       	jmp    101c6b <__alltraps>

001023f1 <vector191>:
.globl vector191
vector191:
  pushl $0
  1023f1:	6a 00                	push   $0x0
  pushl $191
  1023f3:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  1023f8:	e9 6e f8 ff ff       	jmp    101c6b <__alltraps>

001023fd <vector192>:
.globl vector192
vector192:
  pushl $0
  1023fd:	6a 00                	push   $0x0
  pushl $192
  1023ff:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102404:	e9 62 f8 ff ff       	jmp    101c6b <__alltraps>

00102409 <vector193>:
.globl vector193
vector193:
  pushl $0
  102409:	6a 00                	push   $0x0
  pushl $193
  10240b:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102410:	e9 56 f8 ff ff       	jmp    101c6b <__alltraps>

00102415 <vector194>:
.globl vector194
vector194:
  pushl $0
  102415:	6a 00                	push   $0x0
  pushl $194
  102417:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  10241c:	e9 4a f8 ff ff       	jmp    101c6b <__alltraps>

00102421 <vector195>:
.globl vector195
vector195:
  pushl $0
  102421:	6a 00                	push   $0x0
  pushl $195
  102423:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102428:	e9 3e f8 ff ff       	jmp    101c6b <__alltraps>

0010242d <vector196>:
.globl vector196
vector196:
  pushl $0
  10242d:	6a 00                	push   $0x0
  pushl $196
  10242f:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102434:	e9 32 f8 ff ff       	jmp    101c6b <__alltraps>

00102439 <vector197>:
.globl vector197
vector197:
  pushl $0
  102439:	6a 00                	push   $0x0
  pushl $197
  10243b:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102440:	e9 26 f8 ff ff       	jmp    101c6b <__alltraps>

00102445 <vector198>:
.globl vector198
vector198:
  pushl $0
  102445:	6a 00                	push   $0x0
  pushl $198
  102447:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  10244c:	e9 1a f8 ff ff       	jmp    101c6b <__alltraps>

00102451 <vector199>:
.globl vector199
vector199:
  pushl $0
  102451:	6a 00                	push   $0x0
  pushl $199
  102453:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102458:	e9 0e f8 ff ff       	jmp    101c6b <__alltraps>

0010245d <vector200>:
.globl vector200
vector200:
  pushl $0
  10245d:	6a 00                	push   $0x0
  pushl $200
  10245f:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102464:	e9 02 f8 ff ff       	jmp    101c6b <__alltraps>

00102469 <vector201>:
.globl vector201
vector201:
  pushl $0
  102469:	6a 00                	push   $0x0
  pushl $201
  10246b:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  102470:	e9 f6 f7 ff ff       	jmp    101c6b <__alltraps>

00102475 <vector202>:
.globl vector202
vector202:
  pushl $0
  102475:	6a 00                	push   $0x0
  pushl $202
  102477:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  10247c:	e9 ea f7 ff ff       	jmp    101c6b <__alltraps>

00102481 <vector203>:
.globl vector203
vector203:
  pushl $0
  102481:	6a 00                	push   $0x0
  pushl $203
  102483:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102488:	e9 de f7 ff ff       	jmp    101c6b <__alltraps>

0010248d <vector204>:
.globl vector204
vector204:
  pushl $0
  10248d:	6a 00                	push   $0x0
  pushl $204
  10248f:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102494:	e9 d2 f7 ff ff       	jmp    101c6b <__alltraps>

00102499 <vector205>:
.globl vector205
vector205:
  pushl $0
  102499:	6a 00                	push   $0x0
  pushl $205
  10249b:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1024a0:	e9 c6 f7 ff ff       	jmp    101c6b <__alltraps>

001024a5 <vector206>:
.globl vector206
vector206:
  pushl $0
  1024a5:	6a 00                	push   $0x0
  pushl $206
  1024a7:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1024ac:	e9 ba f7 ff ff       	jmp    101c6b <__alltraps>

001024b1 <vector207>:
.globl vector207
vector207:
  pushl $0
  1024b1:	6a 00                	push   $0x0
  pushl $207
  1024b3:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  1024b8:	e9 ae f7 ff ff       	jmp    101c6b <__alltraps>

001024bd <vector208>:
.globl vector208
vector208:
  pushl $0
  1024bd:	6a 00                	push   $0x0
  pushl $208
  1024bf:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  1024c4:	e9 a2 f7 ff ff       	jmp    101c6b <__alltraps>

001024c9 <vector209>:
.globl vector209
vector209:
  pushl $0
  1024c9:	6a 00                	push   $0x0
  pushl $209
  1024cb:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  1024d0:	e9 96 f7 ff ff       	jmp    101c6b <__alltraps>

001024d5 <vector210>:
.globl vector210
vector210:
  pushl $0
  1024d5:	6a 00                	push   $0x0
  pushl $210
  1024d7:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1024dc:	e9 8a f7 ff ff       	jmp    101c6b <__alltraps>

001024e1 <vector211>:
.globl vector211
vector211:
  pushl $0
  1024e1:	6a 00                	push   $0x0
  pushl $211
  1024e3:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1024e8:	e9 7e f7 ff ff       	jmp    101c6b <__alltraps>

001024ed <vector212>:
.globl vector212
vector212:
  pushl $0
  1024ed:	6a 00                	push   $0x0
  pushl $212
  1024ef:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  1024f4:	e9 72 f7 ff ff       	jmp    101c6b <__alltraps>

001024f9 <vector213>:
.globl vector213
vector213:
  pushl $0
  1024f9:	6a 00                	push   $0x0
  pushl $213
  1024fb:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102500:	e9 66 f7 ff ff       	jmp    101c6b <__alltraps>

00102505 <vector214>:
.globl vector214
vector214:
  pushl $0
  102505:	6a 00                	push   $0x0
  pushl $214
  102507:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  10250c:	e9 5a f7 ff ff       	jmp    101c6b <__alltraps>

00102511 <vector215>:
.globl vector215
vector215:
  pushl $0
  102511:	6a 00                	push   $0x0
  pushl $215
  102513:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102518:	e9 4e f7 ff ff       	jmp    101c6b <__alltraps>

0010251d <vector216>:
.globl vector216
vector216:
  pushl $0
  10251d:	6a 00                	push   $0x0
  pushl $216
  10251f:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102524:	e9 42 f7 ff ff       	jmp    101c6b <__alltraps>

00102529 <vector217>:
.globl vector217
vector217:
  pushl $0
  102529:	6a 00                	push   $0x0
  pushl $217
  10252b:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102530:	e9 36 f7 ff ff       	jmp    101c6b <__alltraps>

00102535 <vector218>:
.globl vector218
vector218:
  pushl $0
  102535:	6a 00                	push   $0x0
  pushl $218
  102537:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  10253c:	e9 2a f7 ff ff       	jmp    101c6b <__alltraps>

00102541 <vector219>:
.globl vector219
vector219:
  pushl $0
  102541:	6a 00                	push   $0x0
  pushl $219
  102543:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102548:	e9 1e f7 ff ff       	jmp    101c6b <__alltraps>

0010254d <vector220>:
.globl vector220
vector220:
  pushl $0
  10254d:	6a 00                	push   $0x0
  pushl $220
  10254f:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102554:	e9 12 f7 ff ff       	jmp    101c6b <__alltraps>

00102559 <vector221>:
.globl vector221
vector221:
  pushl $0
  102559:	6a 00                	push   $0x0
  pushl $221
  10255b:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102560:	e9 06 f7 ff ff       	jmp    101c6b <__alltraps>

00102565 <vector222>:
.globl vector222
vector222:
  pushl $0
  102565:	6a 00                	push   $0x0
  pushl $222
  102567:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  10256c:	e9 fa f6 ff ff       	jmp    101c6b <__alltraps>

00102571 <vector223>:
.globl vector223
vector223:
  pushl $0
  102571:	6a 00                	push   $0x0
  pushl $223
  102573:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102578:	e9 ee f6 ff ff       	jmp    101c6b <__alltraps>

0010257d <vector224>:
.globl vector224
vector224:
  pushl $0
  10257d:	6a 00                	push   $0x0
  pushl $224
  10257f:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102584:	e9 e2 f6 ff ff       	jmp    101c6b <__alltraps>

00102589 <vector225>:
.globl vector225
vector225:
  pushl $0
  102589:	6a 00                	push   $0x0
  pushl $225
  10258b:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  102590:	e9 d6 f6 ff ff       	jmp    101c6b <__alltraps>

00102595 <vector226>:
.globl vector226
vector226:
  pushl $0
  102595:	6a 00                	push   $0x0
  pushl $226
  102597:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  10259c:	e9 ca f6 ff ff       	jmp    101c6b <__alltraps>

001025a1 <vector227>:
.globl vector227
vector227:
  pushl $0
  1025a1:	6a 00                	push   $0x0
  pushl $227
  1025a3:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  1025a8:	e9 be f6 ff ff       	jmp    101c6b <__alltraps>

001025ad <vector228>:
.globl vector228
vector228:
  pushl $0
  1025ad:	6a 00                	push   $0x0
  pushl $228
  1025af:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  1025b4:	e9 b2 f6 ff ff       	jmp    101c6b <__alltraps>

001025b9 <vector229>:
.globl vector229
vector229:
  pushl $0
  1025b9:	6a 00                	push   $0x0
  pushl $229
  1025bb:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  1025c0:	e9 a6 f6 ff ff       	jmp    101c6b <__alltraps>

001025c5 <vector230>:
.globl vector230
vector230:
  pushl $0
  1025c5:	6a 00                	push   $0x0
  pushl $230
  1025c7:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  1025cc:	e9 9a f6 ff ff       	jmp    101c6b <__alltraps>

001025d1 <vector231>:
.globl vector231
vector231:
  pushl $0
  1025d1:	6a 00                	push   $0x0
  pushl $231
  1025d3:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1025d8:	e9 8e f6 ff ff       	jmp    101c6b <__alltraps>

001025dd <vector232>:
.globl vector232
vector232:
  pushl $0
  1025dd:	6a 00                	push   $0x0
  pushl $232
  1025df:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  1025e4:	e9 82 f6 ff ff       	jmp    101c6b <__alltraps>

001025e9 <vector233>:
.globl vector233
vector233:
  pushl $0
  1025e9:	6a 00                	push   $0x0
  pushl $233
  1025eb:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  1025f0:	e9 76 f6 ff ff       	jmp    101c6b <__alltraps>

001025f5 <vector234>:
.globl vector234
vector234:
  pushl $0
  1025f5:	6a 00                	push   $0x0
  pushl $234
  1025f7:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  1025fc:	e9 6a f6 ff ff       	jmp    101c6b <__alltraps>

00102601 <vector235>:
.globl vector235
vector235:
  pushl $0
  102601:	6a 00                	push   $0x0
  pushl $235
  102603:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102608:	e9 5e f6 ff ff       	jmp    101c6b <__alltraps>

0010260d <vector236>:
.globl vector236
vector236:
  pushl $0
  10260d:	6a 00                	push   $0x0
  pushl $236
  10260f:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102614:	e9 52 f6 ff ff       	jmp    101c6b <__alltraps>

00102619 <vector237>:
.globl vector237
vector237:
  pushl $0
  102619:	6a 00                	push   $0x0
  pushl $237
  10261b:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102620:	e9 46 f6 ff ff       	jmp    101c6b <__alltraps>

00102625 <vector238>:
.globl vector238
vector238:
  pushl $0
  102625:	6a 00                	push   $0x0
  pushl $238
  102627:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  10262c:	e9 3a f6 ff ff       	jmp    101c6b <__alltraps>

00102631 <vector239>:
.globl vector239
vector239:
  pushl $0
  102631:	6a 00                	push   $0x0
  pushl $239
  102633:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102638:	e9 2e f6 ff ff       	jmp    101c6b <__alltraps>

0010263d <vector240>:
.globl vector240
vector240:
  pushl $0
  10263d:	6a 00                	push   $0x0
  pushl $240
  10263f:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102644:	e9 22 f6 ff ff       	jmp    101c6b <__alltraps>

00102649 <vector241>:
.globl vector241
vector241:
  pushl $0
  102649:	6a 00                	push   $0x0
  pushl $241
  10264b:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102650:	e9 16 f6 ff ff       	jmp    101c6b <__alltraps>

00102655 <vector242>:
.globl vector242
vector242:
  pushl $0
  102655:	6a 00                	push   $0x0
  pushl $242
  102657:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  10265c:	e9 0a f6 ff ff       	jmp    101c6b <__alltraps>

00102661 <vector243>:
.globl vector243
vector243:
  pushl $0
  102661:	6a 00                	push   $0x0
  pushl $243
  102663:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102668:	e9 fe f5 ff ff       	jmp    101c6b <__alltraps>

0010266d <vector244>:
.globl vector244
vector244:
  pushl $0
  10266d:	6a 00                	push   $0x0
  pushl $244
  10266f:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102674:	e9 f2 f5 ff ff       	jmp    101c6b <__alltraps>

00102679 <vector245>:
.globl vector245
vector245:
  pushl $0
  102679:	6a 00                	push   $0x0
  pushl $245
  10267b:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102680:	e9 e6 f5 ff ff       	jmp    101c6b <__alltraps>

00102685 <vector246>:
.globl vector246
vector246:
  pushl $0
  102685:	6a 00                	push   $0x0
  pushl $246
  102687:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  10268c:	e9 da f5 ff ff       	jmp    101c6b <__alltraps>

00102691 <vector247>:
.globl vector247
vector247:
  pushl $0
  102691:	6a 00                	push   $0x0
  pushl $247
  102693:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102698:	e9 ce f5 ff ff       	jmp    101c6b <__alltraps>

0010269d <vector248>:
.globl vector248
vector248:
  pushl $0
  10269d:	6a 00                	push   $0x0
  pushl $248
  10269f:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  1026a4:	e9 c2 f5 ff ff       	jmp    101c6b <__alltraps>

001026a9 <vector249>:
.globl vector249
vector249:
  pushl $0
  1026a9:	6a 00                	push   $0x0
  pushl $249
  1026ab:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  1026b0:	e9 b6 f5 ff ff       	jmp    101c6b <__alltraps>

001026b5 <vector250>:
.globl vector250
vector250:
  pushl $0
  1026b5:	6a 00                	push   $0x0
  pushl $250
  1026b7:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  1026bc:	e9 aa f5 ff ff       	jmp    101c6b <__alltraps>

001026c1 <vector251>:
.globl vector251
vector251:
  pushl $0
  1026c1:	6a 00                	push   $0x0
  pushl $251
  1026c3:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  1026c8:	e9 9e f5 ff ff       	jmp    101c6b <__alltraps>

001026cd <vector252>:
.globl vector252
vector252:
  pushl $0
  1026cd:	6a 00                	push   $0x0
  pushl $252
  1026cf:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1026d4:	e9 92 f5 ff ff       	jmp    101c6b <__alltraps>

001026d9 <vector253>:
.globl vector253
vector253:
  pushl $0
  1026d9:	6a 00                	push   $0x0
  pushl $253
  1026db:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  1026e0:	e9 86 f5 ff ff       	jmp    101c6b <__alltraps>

001026e5 <vector254>:
.globl vector254
vector254:
  pushl $0
  1026e5:	6a 00                	push   $0x0
  pushl $254
  1026e7:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  1026ec:	e9 7a f5 ff ff       	jmp    101c6b <__alltraps>

001026f1 <vector255>:
.globl vector255
vector255:
  pushl $0
  1026f1:	6a 00                	push   $0x0
  pushl $255
  1026f3:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  1026f8:	e9 6e f5 ff ff       	jmp    101c6b <__alltraps>

001026fd <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  1026fd:	55                   	push   %ebp
  1026fe:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102700:	8b 45 08             	mov    0x8(%ebp),%eax
  102703:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102706:	b8 23 00 00 00       	mov    $0x23,%eax
  10270b:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  10270d:	b8 23 00 00 00       	mov    $0x23,%eax
  102712:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102714:	b8 10 00 00 00       	mov    $0x10,%eax
  102719:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  10271b:	b8 10 00 00 00       	mov    $0x10,%eax
  102720:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102722:	b8 10 00 00 00       	mov    $0x10,%eax
  102727:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102729:	ea 30 27 10 00 08 00 	ljmp   $0x8,$0x102730
}
  102730:	5d                   	pop    %ebp
  102731:	c3                   	ret    

00102732 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102732:	55                   	push   %ebp
  102733:	89 e5                	mov    %esp,%ebp
  102735:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102738:	b8 20 f9 10 00       	mov    $0x10f920,%eax
  10273d:	05 00 04 00 00       	add    $0x400,%eax
  102742:	a3 a4 f8 10 00       	mov    %eax,0x10f8a4
    ts.ts_ss0 = KERNEL_DS;
  102747:	66 c7 05 a8 f8 10 00 	movw   $0x10,0x10f8a8
  10274e:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102750:	66 c7 05 08 ea 10 00 	movw   $0x68,0x10ea08
  102757:	68 00 
  102759:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  10275e:	66 a3 0a ea 10 00    	mov    %ax,0x10ea0a
  102764:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102769:	c1 e8 10             	shr    $0x10,%eax
  10276c:	a2 0c ea 10 00       	mov    %al,0x10ea0c
  102771:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102778:	83 e0 f0             	and    $0xfffffff0,%eax
  10277b:	83 c8 09             	or     $0x9,%eax
  10277e:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102783:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  10278a:	83 c8 10             	or     $0x10,%eax
  10278d:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102792:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102799:	83 e0 9f             	and    $0xffffff9f,%eax
  10279c:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1027a1:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1027a8:	83 c8 80             	or     $0xffffff80,%eax
  1027ab:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1027b0:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1027b7:	83 e0 f0             	and    $0xfffffff0,%eax
  1027ba:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1027bf:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1027c6:	83 e0 ef             	and    $0xffffffef,%eax
  1027c9:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1027ce:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1027d5:	83 e0 df             	and    $0xffffffdf,%eax
  1027d8:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1027dd:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1027e4:	83 c8 40             	or     $0x40,%eax
  1027e7:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1027ec:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1027f3:	83 e0 7f             	and    $0x7f,%eax
  1027f6:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1027fb:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102800:	c1 e8 18             	shr    $0x18,%eax
  102803:	a2 0f ea 10 00       	mov    %al,0x10ea0f
    gdt[SEG_TSS].sd_s = 0;
  102808:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  10280f:	83 e0 ef             	and    $0xffffffef,%eax
  102812:	a2 0d ea 10 00       	mov    %al,0x10ea0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102817:	c7 04 24 10 ea 10 00 	movl   $0x10ea10,(%esp)
  10281e:	e8 da fe ff ff       	call   1026fd <lgdt>
  102823:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("cli");
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102829:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  10282d:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  102830:	c9                   	leave  
  102831:	c3                   	ret    

00102832 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102832:	55                   	push   %ebp
  102833:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102835:	e8 f8 fe ff ff       	call   102732 <gdt_init>
}
  10283a:	5d                   	pop    %ebp
  10283b:	c3                   	ret    

0010283c <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  10283c:	55                   	push   %ebp
  10283d:	89 e5                	mov    %esp,%ebp
  10283f:	83 ec 58             	sub    $0x58,%esp
  102842:	8b 45 10             	mov    0x10(%ebp),%eax
  102845:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102848:	8b 45 14             	mov    0x14(%ebp),%eax
  10284b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  10284e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102851:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102854:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102857:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  10285a:	8b 45 18             	mov    0x18(%ebp),%eax
  10285d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102860:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102863:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102866:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102869:	89 55 f0             	mov    %edx,-0x10(%ebp)
  10286c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10286f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102872:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102876:	74 1c                	je     102894 <printnum+0x58>
  102878:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10287b:	ba 00 00 00 00       	mov    $0x0,%edx
  102880:	f7 75 e4             	divl   -0x1c(%ebp)
  102883:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102886:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102889:	ba 00 00 00 00       	mov    $0x0,%edx
  10288e:	f7 75 e4             	divl   -0x1c(%ebp)
  102891:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102894:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102897:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10289a:	f7 75 e4             	divl   -0x1c(%ebp)
  10289d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1028a0:	89 55 dc             	mov    %edx,-0x24(%ebp)
  1028a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1028a6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1028a9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1028ac:	89 55 ec             	mov    %edx,-0x14(%ebp)
  1028af:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1028b2:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  1028b5:	8b 45 18             	mov    0x18(%ebp),%eax
  1028b8:	ba 00 00 00 00       	mov    $0x0,%edx
  1028bd:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  1028c0:	77 56                	ja     102918 <printnum+0xdc>
  1028c2:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  1028c5:	72 05                	jb     1028cc <printnum+0x90>
  1028c7:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  1028ca:	77 4c                	ja     102918 <printnum+0xdc>
        printnum(putch, putdat, result, base, width - 1, padc);
  1028cc:	8b 45 1c             	mov    0x1c(%ebp),%eax
  1028cf:	8d 50 ff             	lea    -0x1(%eax),%edx
  1028d2:	8b 45 20             	mov    0x20(%ebp),%eax
  1028d5:	89 44 24 18          	mov    %eax,0x18(%esp)
  1028d9:	89 54 24 14          	mov    %edx,0x14(%esp)
  1028dd:	8b 45 18             	mov    0x18(%ebp),%eax
  1028e0:	89 44 24 10          	mov    %eax,0x10(%esp)
  1028e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1028e7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1028ea:	89 44 24 08          	mov    %eax,0x8(%esp)
  1028ee:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1028f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1028f5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1028f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1028fc:	89 04 24             	mov    %eax,(%esp)
  1028ff:	e8 38 ff ff ff       	call   10283c <printnum>
  102904:	eb 1c                	jmp    102922 <printnum+0xe6>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  102906:	8b 45 0c             	mov    0xc(%ebp),%eax
  102909:	89 44 24 04          	mov    %eax,0x4(%esp)
  10290d:	8b 45 20             	mov    0x20(%ebp),%eax
  102910:	89 04 24             	mov    %eax,(%esp)
  102913:	8b 45 08             	mov    0x8(%ebp),%eax
  102916:	ff d0                	call   *%eax
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  102918:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  10291c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  102920:	7f e4                	jg     102906 <printnum+0xca>
            putch(padc, putdat);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  102922:	8b 45 d8             	mov    -0x28(%ebp),%eax
  102925:	05 d0 3a 10 00       	add    $0x103ad0,%eax
  10292a:	0f b6 00             	movzbl (%eax),%eax
  10292d:	0f be c0             	movsbl %al,%eax
  102930:	8b 55 0c             	mov    0xc(%ebp),%edx
  102933:	89 54 24 04          	mov    %edx,0x4(%esp)
  102937:	89 04 24             	mov    %eax,(%esp)
  10293a:	8b 45 08             	mov    0x8(%ebp),%eax
  10293d:	ff d0                	call   *%eax
}
  10293f:	c9                   	leave  
  102940:	c3                   	ret    

00102941 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  102941:	55                   	push   %ebp
  102942:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102944:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102948:	7e 14                	jle    10295e <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  10294a:	8b 45 08             	mov    0x8(%ebp),%eax
  10294d:	8b 00                	mov    (%eax),%eax
  10294f:	8d 48 08             	lea    0x8(%eax),%ecx
  102952:	8b 55 08             	mov    0x8(%ebp),%edx
  102955:	89 0a                	mov    %ecx,(%edx)
  102957:	8b 50 04             	mov    0x4(%eax),%edx
  10295a:	8b 00                	mov    (%eax),%eax
  10295c:	eb 30                	jmp    10298e <getuint+0x4d>
    }
    else if (lflag) {
  10295e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102962:	74 16                	je     10297a <getuint+0x39>
        return va_arg(*ap, unsigned long);
  102964:	8b 45 08             	mov    0x8(%ebp),%eax
  102967:	8b 00                	mov    (%eax),%eax
  102969:	8d 48 04             	lea    0x4(%eax),%ecx
  10296c:	8b 55 08             	mov    0x8(%ebp),%edx
  10296f:	89 0a                	mov    %ecx,(%edx)
  102971:	8b 00                	mov    (%eax),%eax
  102973:	ba 00 00 00 00       	mov    $0x0,%edx
  102978:	eb 14                	jmp    10298e <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  10297a:	8b 45 08             	mov    0x8(%ebp),%eax
  10297d:	8b 00                	mov    (%eax),%eax
  10297f:	8d 48 04             	lea    0x4(%eax),%ecx
  102982:	8b 55 08             	mov    0x8(%ebp),%edx
  102985:	89 0a                	mov    %ecx,(%edx)
  102987:	8b 00                	mov    (%eax),%eax
  102989:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  10298e:	5d                   	pop    %ebp
  10298f:	c3                   	ret    

00102990 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  102990:	55                   	push   %ebp
  102991:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102993:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102997:	7e 14                	jle    1029ad <getint+0x1d>
        return va_arg(*ap, long long);
  102999:	8b 45 08             	mov    0x8(%ebp),%eax
  10299c:	8b 00                	mov    (%eax),%eax
  10299e:	8d 48 08             	lea    0x8(%eax),%ecx
  1029a1:	8b 55 08             	mov    0x8(%ebp),%edx
  1029a4:	89 0a                	mov    %ecx,(%edx)
  1029a6:	8b 50 04             	mov    0x4(%eax),%edx
  1029a9:	8b 00                	mov    (%eax),%eax
  1029ab:	eb 28                	jmp    1029d5 <getint+0x45>
    }
    else if (lflag) {
  1029ad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1029b1:	74 12                	je     1029c5 <getint+0x35>
        return va_arg(*ap, long);
  1029b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1029b6:	8b 00                	mov    (%eax),%eax
  1029b8:	8d 48 04             	lea    0x4(%eax),%ecx
  1029bb:	8b 55 08             	mov    0x8(%ebp),%edx
  1029be:	89 0a                	mov    %ecx,(%edx)
  1029c0:	8b 00                	mov    (%eax),%eax
  1029c2:	99                   	cltd   
  1029c3:	eb 10                	jmp    1029d5 <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  1029c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1029c8:	8b 00                	mov    (%eax),%eax
  1029ca:	8d 48 04             	lea    0x4(%eax),%ecx
  1029cd:	8b 55 08             	mov    0x8(%ebp),%edx
  1029d0:	89 0a                	mov    %ecx,(%edx)
  1029d2:	8b 00                	mov    (%eax),%eax
  1029d4:	99                   	cltd   
    }
}
  1029d5:	5d                   	pop    %ebp
  1029d6:	c3                   	ret    

001029d7 <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  1029d7:	55                   	push   %ebp
  1029d8:	89 e5                	mov    %esp,%ebp
  1029da:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  1029dd:	8d 45 14             	lea    0x14(%ebp),%eax
  1029e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  1029e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1029e6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1029ea:	8b 45 10             	mov    0x10(%ebp),%eax
  1029ed:	89 44 24 08          	mov    %eax,0x8(%esp)
  1029f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1029f4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1029f8:	8b 45 08             	mov    0x8(%ebp),%eax
  1029fb:	89 04 24             	mov    %eax,(%esp)
  1029fe:	e8 02 00 00 00       	call   102a05 <vprintfmt>
    va_end(ap);
}
  102a03:	c9                   	leave  
  102a04:	c3                   	ret    

00102a05 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  102a05:	55                   	push   %ebp
  102a06:	89 e5                	mov    %esp,%ebp
  102a08:	56                   	push   %esi
  102a09:	53                   	push   %ebx
  102a0a:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102a0d:	eb 18                	jmp    102a27 <vprintfmt+0x22>
            if (ch == '\0') {
  102a0f:	85 db                	test   %ebx,%ebx
  102a11:	75 05                	jne    102a18 <vprintfmt+0x13>
                return;
  102a13:	e9 d1 03 00 00       	jmp    102de9 <vprintfmt+0x3e4>
            }
            putch(ch, putdat);
  102a18:	8b 45 0c             	mov    0xc(%ebp),%eax
  102a1b:	89 44 24 04          	mov    %eax,0x4(%esp)
  102a1f:	89 1c 24             	mov    %ebx,(%esp)
  102a22:	8b 45 08             	mov    0x8(%ebp),%eax
  102a25:	ff d0                	call   *%eax
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102a27:	8b 45 10             	mov    0x10(%ebp),%eax
  102a2a:	8d 50 01             	lea    0x1(%eax),%edx
  102a2d:	89 55 10             	mov    %edx,0x10(%ebp)
  102a30:	0f b6 00             	movzbl (%eax),%eax
  102a33:	0f b6 d8             	movzbl %al,%ebx
  102a36:	83 fb 25             	cmp    $0x25,%ebx
  102a39:	75 d4                	jne    102a0f <vprintfmt+0xa>
            }
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
  102a3b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  102a3f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  102a46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102a49:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  102a4c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102a53:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102a56:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  102a59:	8b 45 10             	mov    0x10(%ebp),%eax
  102a5c:	8d 50 01             	lea    0x1(%eax),%edx
  102a5f:	89 55 10             	mov    %edx,0x10(%ebp)
  102a62:	0f b6 00             	movzbl (%eax),%eax
  102a65:	0f b6 d8             	movzbl %al,%ebx
  102a68:	8d 43 dd             	lea    -0x23(%ebx),%eax
  102a6b:	83 f8 55             	cmp    $0x55,%eax
  102a6e:	0f 87 44 03 00 00    	ja     102db8 <vprintfmt+0x3b3>
  102a74:	8b 04 85 f4 3a 10 00 	mov    0x103af4(,%eax,4),%eax
  102a7b:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  102a7d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  102a81:	eb d6                	jmp    102a59 <vprintfmt+0x54>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  102a83:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  102a87:	eb d0                	jmp    102a59 <vprintfmt+0x54>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102a89:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  102a90:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102a93:	89 d0                	mov    %edx,%eax
  102a95:	c1 e0 02             	shl    $0x2,%eax
  102a98:	01 d0                	add    %edx,%eax
  102a9a:	01 c0                	add    %eax,%eax
  102a9c:	01 d8                	add    %ebx,%eax
  102a9e:	83 e8 30             	sub    $0x30,%eax
  102aa1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  102aa4:	8b 45 10             	mov    0x10(%ebp),%eax
  102aa7:	0f b6 00             	movzbl (%eax),%eax
  102aaa:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  102aad:	83 fb 2f             	cmp    $0x2f,%ebx
  102ab0:	7e 0b                	jle    102abd <vprintfmt+0xb8>
  102ab2:	83 fb 39             	cmp    $0x39,%ebx
  102ab5:	7f 06                	jg     102abd <vprintfmt+0xb8>
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102ab7:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
  102abb:	eb d3                	jmp    102a90 <vprintfmt+0x8b>
            goto process_precision;
  102abd:	eb 33                	jmp    102af2 <vprintfmt+0xed>

        case '*':
            precision = va_arg(ap, int);
  102abf:	8b 45 14             	mov    0x14(%ebp),%eax
  102ac2:	8d 50 04             	lea    0x4(%eax),%edx
  102ac5:	89 55 14             	mov    %edx,0x14(%ebp)
  102ac8:	8b 00                	mov    (%eax),%eax
  102aca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  102acd:	eb 23                	jmp    102af2 <vprintfmt+0xed>

        case '.':
            if (width < 0)
  102acf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102ad3:	79 0c                	jns    102ae1 <vprintfmt+0xdc>
                width = 0;
  102ad5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  102adc:	e9 78 ff ff ff       	jmp    102a59 <vprintfmt+0x54>
  102ae1:	e9 73 ff ff ff       	jmp    102a59 <vprintfmt+0x54>

        case '#':
            altflag = 1;
  102ae6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  102aed:	e9 67 ff ff ff       	jmp    102a59 <vprintfmt+0x54>

        process_precision:
            if (width < 0)
  102af2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102af6:	79 12                	jns    102b0a <vprintfmt+0x105>
                width = precision, precision = -1;
  102af8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102afb:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102afe:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  102b05:	e9 4f ff ff ff       	jmp    102a59 <vprintfmt+0x54>
  102b0a:	e9 4a ff ff ff       	jmp    102a59 <vprintfmt+0x54>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  102b0f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  102b13:	e9 41 ff ff ff       	jmp    102a59 <vprintfmt+0x54>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  102b18:	8b 45 14             	mov    0x14(%ebp),%eax
  102b1b:	8d 50 04             	lea    0x4(%eax),%edx
  102b1e:	89 55 14             	mov    %edx,0x14(%ebp)
  102b21:	8b 00                	mov    (%eax),%eax
  102b23:	8b 55 0c             	mov    0xc(%ebp),%edx
  102b26:	89 54 24 04          	mov    %edx,0x4(%esp)
  102b2a:	89 04 24             	mov    %eax,(%esp)
  102b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  102b30:	ff d0                	call   *%eax
            break;
  102b32:	e9 ac 02 00 00       	jmp    102de3 <vprintfmt+0x3de>

        // error message
        case 'e':
            err = va_arg(ap, int);
  102b37:	8b 45 14             	mov    0x14(%ebp),%eax
  102b3a:	8d 50 04             	lea    0x4(%eax),%edx
  102b3d:	89 55 14             	mov    %edx,0x14(%ebp)
  102b40:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  102b42:	85 db                	test   %ebx,%ebx
  102b44:	79 02                	jns    102b48 <vprintfmt+0x143>
                err = -err;
  102b46:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  102b48:	83 fb 06             	cmp    $0x6,%ebx
  102b4b:	7f 0b                	jg     102b58 <vprintfmt+0x153>
  102b4d:	8b 34 9d b4 3a 10 00 	mov    0x103ab4(,%ebx,4),%esi
  102b54:	85 f6                	test   %esi,%esi
  102b56:	75 23                	jne    102b7b <vprintfmt+0x176>
                printfmt(putch, putdat, "error %d", err);
  102b58:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  102b5c:	c7 44 24 08 e1 3a 10 	movl   $0x103ae1,0x8(%esp)
  102b63:	00 
  102b64:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b67:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b6b:	8b 45 08             	mov    0x8(%ebp),%eax
  102b6e:	89 04 24             	mov    %eax,(%esp)
  102b71:	e8 61 fe ff ff       	call   1029d7 <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  102b76:	e9 68 02 00 00       	jmp    102de3 <vprintfmt+0x3de>
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, putdat, "error %d", err);
            }
            else {
                printfmt(putch, putdat, "%s", p);
  102b7b:	89 74 24 0c          	mov    %esi,0xc(%esp)
  102b7f:	c7 44 24 08 ea 3a 10 	movl   $0x103aea,0x8(%esp)
  102b86:	00 
  102b87:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b8e:	8b 45 08             	mov    0x8(%ebp),%eax
  102b91:	89 04 24             	mov    %eax,(%esp)
  102b94:	e8 3e fe ff ff       	call   1029d7 <printfmt>
            }
            break;
  102b99:	e9 45 02 00 00       	jmp    102de3 <vprintfmt+0x3de>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  102b9e:	8b 45 14             	mov    0x14(%ebp),%eax
  102ba1:	8d 50 04             	lea    0x4(%eax),%edx
  102ba4:	89 55 14             	mov    %edx,0x14(%ebp)
  102ba7:	8b 30                	mov    (%eax),%esi
  102ba9:	85 f6                	test   %esi,%esi
  102bab:	75 05                	jne    102bb2 <vprintfmt+0x1ad>
                p = "(null)";
  102bad:	be ed 3a 10 00       	mov    $0x103aed,%esi
            }
            if (width > 0 && padc != '-') {
  102bb2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102bb6:	7e 3e                	jle    102bf6 <vprintfmt+0x1f1>
  102bb8:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  102bbc:	74 38                	je     102bf6 <vprintfmt+0x1f1>
                for (width -= strnlen(p, precision); width > 0; width --) {
  102bbe:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  102bc1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102bc4:	89 44 24 04          	mov    %eax,0x4(%esp)
  102bc8:	89 34 24             	mov    %esi,(%esp)
  102bcb:	e8 15 03 00 00       	call   102ee5 <strnlen>
  102bd0:	29 c3                	sub    %eax,%ebx
  102bd2:	89 d8                	mov    %ebx,%eax
  102bd4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102bd7:	eb 17                	jmp    102bf0 <vprintfmt+0x1eb>
                    putch(padc, putdat);
  102bd9:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  102bdd:	8b 55 0c             	mov    0xc(%ebp),%edx
  102be0:	89 54 24 04          	mov    %edx,0x4(%esp)
  102be4:	89 04 24             	mov    %eax,(%esp)
  102be7:	8b 45 08             	mov    0x8(%ebp),%eax
  102bea:	ff d0                	call   *%eax
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
  102bec:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102bf0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102bf4:	7f e3                	jg     102bd9 <vprintfmt+0x1d4>
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102bf6:	eb 38                	jmp    102c30 <vprintfmt+0x22b>
                if (altflag && (ch < ' ' || ch > '~')) {
  102bf8:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  102bfc:	74 1f                	je     102c1d <vprintfmt+0x218>
  102bfe:	83 fb 1f             	cmp    $0x1f,%ebx
  102c01:	7e 05                	jle    102c08 <vprintfmt+0x203>
  102c03:	83 fb 7e             	cmp    $0x7e,%ebx
  102c06:	7e 15                	jle    102c1d <vprintfmt+0x218>
                    putch('?', putdat);
  102c08:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c0b:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c0f:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  102c16:	8b 45 08             	mov    0x8(%ebp),%eax
  102c19:	ff d0                	call   *%eax
  102c1b:	eb 0f                	jmp    102c2c <vprintfmt+0x227>
                }
                else {
                    putch(ch, putdat);
  102c1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c20:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c24:	89 1c 24             	mov    %ebx,(%esp)
  102c27:	8b 45 08             	mov    0x8(%ebp),%eax
  102c2a:	ff d0                	call   *%eax
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102c2c:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102c30:	89 f0                	mov    %esi,%eax
  102c32:	8d 70 01             	lea    0x1(%eax),%esi
  102c35:	0f b6 00             	movzbl (%eax),%eax
  102c38:	0f be d8             	movsbl %al,%ebx
  102c3b:	85 db                	test   %ebx,%ebx
  102c3d:	74 10                	je     102c4f <vprintfmt+0x24a>
  102c3f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102c43:	78 b3                	js     102bf8 <vprintfmt+0x1f3>
  102c45:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  102c49:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102c4d:	79 a9                	jns    102bf8 <vprintfmt+0x1f3>
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102c4f:	eb 17                	jmp    102c68 <vprintfmt+0x263>
                putch(' ', putdat);
  102c51:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c54:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c58:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  102c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  102c62:	ff d0                	call   *%eax
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102c64:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102c68:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102c6c:	7f e3                	jg     102c51 <vprintfmt+0x24c>
                putch(' ', putdat);
            }
            break;
  102c6e:	e9 70 01 00 00       	jmp    102de3 <vprintfmt+0x3de>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  102c73:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102c76:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c7a:	8d 45 14             	lea    0x14(%ebp),%eax
  102c7d:	89 04 24             	mov    %eax,(%esp)
  102c80:	e8 0b fd ff ff       	call   102990 <getint>
  102c85:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102c88:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  102c8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c91:	85 d2                	test   %edx,%edx
  102c93:	79 26                	jns    102cbb <vprintfmt+0x2b6>
                putch('-', putdat);
  102c95:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c98:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c9c:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  102ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  102ca6:	ff d0                	call   *%eax
                num = -(long long)num;
  102ca8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102cab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102cae:	f7 d8                	neg    %eax
  102cb0:	83 d2 00             	adc    $0x0,%edx
  102cb3:	f7 da                	neg    %edx
  102cb5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102cb8:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  102cbb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102cc2:	e9 a8 00 00 00       	jmp    102d6f <vprintfmt+0x36a>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  102cc7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102cca:	89 44 24 04          	mov    %eax,0x4(%esp)
  102cce:	8d 45 14             	lea    0x14(%ebp),%eax
  102cd1:	89 04 24             	mov    %eax,(%esp)
  102cd4:	e8 68 fc ff ff       	call   102941 <getuint>
  102cd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102cdc:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  102cdf:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102ce6:	e9 84 00 00 00       	jmp    102d6f <vprintfmt+0x36a>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  102ceb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102cee:	89 44 24 04          	mov    %eax,0x4(%esp)
  102cf2:	8d 45 14             	lea    0x14(%ebp),%eax
  102cf5:	89 04 24             	mov    %eax,(%esp)
  102cf8:	e8 44 fc ff ff       	call   102941 <getuint>
  102cfd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102d00:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  102d03:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  102d0a:	eb 63                	jmp    102d6f <vprintfmt+0x36a>

        // pointer
        case 'p':
            putch('0', putdat);
  102d0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d0f:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d13:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  102d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  102d1d:	ff d0                	call   *%eax
            putch('x', putdat);
  102d1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d22:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d26:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  102d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  102d30:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  102d32:	8b 45 14             	mov    0x14(%ebp),%eax
  102d35:	8d 50 04             	lea    0x4(%eax),%edx
  102d38:	89 55 14             	mov    %edx,0x14(%ebp)
  102d3b:	8b 00                	mov    (%eax),%eax
  102d3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102d40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  102d47:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  102d4e:	eb 1f                	jmp    102d6f <vprintfmt+0x36a>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  102d50:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102d53:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d57:	8d 45 14             	lea    0x14(%ebp),%eax
  102d5a:	89 04 24             	mov    %eax,(%esp)
  102d5d:	e8 df fb ff ff       	call   102941 <getuint>
  102d62:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102d65:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  102d68:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  102d6f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  102d73:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102d76:	89 54 24 18          	mov    %edx,0x18(%esp)
  102d7a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  102d7d:	89 54 24 14          	mov    %edx,0x14(%esp)
  102d81:	89 44 24 10          	mov    %eax,0x10(%esp)
  102d85:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d88:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102d8b:	89 44 24 08          	mov    %eax,0x8(%esp)
  102d8f:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102d93:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d96:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d9a:	8b 45 08             	mov    0x8(%ebp),%eax
  102d9d:	89 04 24             	mov    %eax,(%esp)
  102da0:	e8 97 fa ff ff       	call   10283c <printnum>
            break;
  102da5:	eb 3c                	jmp    102de3 <vprintfmt+0x3de>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  102da7:	8b 45 0c             	mov    0xc(%ebp),%eax
  102daa:	89 44 24 04          	mov    %eax,0x4(%esp)
  102dae:	89 1c 24             	mov    %ebx,(%esp)
  102db1:	8b 45 08             	mov    0x8(%ebp),%eax
  102db4:	ff d0                	call   *%eax
            break;
  102db6:	eb 2b                	jmp    102de3 <vprintfmt+0x3de>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  102db8:	8b 45 0c             	mov    0xc(%ebp),%eax
  102dbb:	89 44 24 04          	mov    %eax,0x4(%esp)
  102dbf:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  102dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  102dc9:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  102dcb:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102dcf:	eb 04                	jmp    102dd5 <vprintfmt+0x3d0>
  102dd1:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102dd5:	8b 45 10             	mov    0x10(%ebp),%eax
  102dd8:	83 e8 01             	sub    $0x1,%eax
  102ddb:	0f b6 00             	movzbl (%eax),%eax
  102dde:	3c 25                	cmp    $0x25,%al
  102de0:	75 ef                	jne    102dd1 <vprintfmt+0x3cc>
                /* do nothing */;
            break;
  102de2:	90                   	nop
        }
    }
  102de3:	90                   	nop
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102de4:	e9 3e fc ff ff       	jmp    102a27 <vprintfmt+0x22>
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  102de9:	83 c4 40             	add    $0x40,%esp
  102dec:	5b                   	pop    %ebx
  102ded:	5e                   	pop    %esi
  102dee:	5d                   	pop    %ebp
  102def:	c3                   	ret    

00102df0 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  102df0:	55                   	push   %ebp
  102df1:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  102df3:	8b 45 0c             	mov    0xc(%ebp),%eax
  102df6:	8b 40 08             	mov    0x8(%eax),%eax
  102df9:	8d 50 01             	lea    0x1(%eax),%edx
  102dfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  102dff:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  102e02:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e05:	8b 10                	mov    (%eax),%edx
  102e07:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e0a:	8b 40 04             	mov    0x4(%eax),%eax
  102e0d:	39 c2                	cmp    %eax,%edx
  102e0f:	73 12                	jae    102e23 <sprintputch+0x33>
        *b->buf ++ = ch;
  102e11:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e14:	8b 00                	mov    (%eax),%eax
  102e16:	8d 48 01             	lea    0x1(%eax),%ecx
  102e19:	8b 55 0c             	mov    0xc(%ebp),%edx
  102e1c:	89 0a                	mov    %ecx,(%edx)
  102e1e:	8b 55 08             	mov    0x8(%ebp),%edx
  102e21:	88 10                	mov    %dl,(%eax)
    }
}
  102e23:	5d                   	pop    %ebp
  102e24:	c3                   	ret    

00102e25 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  102e25:	55                   	push   %ebp
  102e26:	89 e5                	mov    %esp,%ebp
  102e28:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  102e2b:	8d 45 14             	lea    0x14(%ebp),%eax
  102e2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  102e31:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e34:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102e38:	8b 45 10             	mov    0x10(%ebp),%eax
  102e3b:	89 44 24 08          	mov    %eax,0x8(%esp)
  102e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e42:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e46:	8b 45 08             	mov    0x8(%ebp),%eax
  102e49:	89 04 24             	mov    %eax,(%esp)
  102e4c:	e8 08 00 00 00       	call   102e59 <vsnprintf>
  102e51:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  102e54:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  102e57:	c9                   	leave  
  102e58:	c3                   	ret    

00102e59 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  102e59:	55                   	push   %ebp
  102e5a:	89 e5                	mov    %esp,%ebp
  102e5c:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  102e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  102e62:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102e65:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e68:	8d 50 ff             	lea    -0x1(%eax),%edx
  102e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  102e6e:	01 d0                	add    %edx,%eax
  102e70:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102e73:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  102e7a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  102e7e:	74 0a                	je     102e8a <vsnprintf+0x31>
  102e80:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102e83:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e86:	39 c2                	cmp    %eax,%edx
  102e88:	76 07                	jbe    102e91 <vsnprintf+0x38>
        return -E_INVAL;
  102e8a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  102e8f:	eb 2a                	jmp    102ebb <vsnprintf+0x62>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  102e91:	8b 45 14             	mov    0x14(%ebp),%eax
  102e94:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102e98:	8b 45 10             	mov    0x10(%ebp),%eax
  102e9b:	89 44 24 08          	mov    %eax,0x8(%esp)
  102e9f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  102ea2:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ea6:	c7 04 24 f0 2d 10 00 	movl   $0x102df0,(%esp)
  102ead:	e8 53 fb ff ff       	call   102a05 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  102eb2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102eb5:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  102eb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  102ebb:	c9                   	leave  
  102ebc:	c3                   	ret    

00102ebd <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102ebd:	55                   	push   %ebp
  102ebe:	89 e5                	mov    %esp,%ebp
  102ec0:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102ec3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102eca:	eb 04                	jmp    102ed0 <strlen+0x13>
        cnt ++;
  102ecc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  102ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  102ed3:	8d 50 01             	lea    0x1(%eax),%edx
  102ed6:	89 55 08             	mov    %edx,0x8(%ebp)
  102ed9:	0f b6 00             	movzbl (%eax),%eax
  102edc:	84 c0                	test   %al,%al
  102ede:	75 ec                	jne    102ecc <strlen+0xf>
        cnt ++;
    }
    return cnt;
  102ee0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102ee3:	c9                   	leave  
  102ee4:	c3                   	ret    

00102ee5 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102ee5:	55                   	push   %ebp
  102ee6:	89 e5                	mov    %esp,%ebp
  102ee8:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102eeb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102ef2:	eb 04                	jmp    102ef8 <strnlen+0x13>
        cnt ++;
  102ef4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
  102ef8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102efb:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102efe:	73 10                	jae    102f10 <strnlen+0x2b>
  102f00:	8b 45 08             	mov    0x8(%ebp),%eax
  102f03:	8d 50 01             	lea    0x1(%eax),%edx
  102f06:	89 55 08             	mov    %edx,0x8(%ebp)
  102f09:	0f b6 00             	movzbl (%eax),%eax
  102f0c:	84 c0                	test   %al,%al
  102f0e:	75 e4                	jne    102ef4 <strnlen+0xf>
        cnt ++;
    }
    return cnt;
  102f10:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102f13:	c9                   	leave  
  102f14:	c3                   	ret    

00102f15 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102f15:	55                   	push   %ebp
  102f16:	89 e5                	mov    %esp,%ebp
  102f18:	57                   	push   %edi
  102f19:	56                   	push   %esi
  102f1a:	83 ec 20             	sub    $0x20,%esp
  102f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  102f20:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102f23:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f26:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102f29:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102f2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102f2f:	89 d1                	mov    %edx,%ecx
  102f31:	89 c2                	mov    %eax,%edx
  102f33:	89 ce                	mov    %ecx,%esi
  102f35:	89 d7                	mov    %edx,%edi
  102f37:	ac                   	lods   %ds:(%esi),%al
  102f38:	aa                   	stos   %al,%es:(%edi)
  102f39:	84 c0                	test   %al,%al
  102f3b:	75 fa                	jne    102f37 <strcpy+0x22>
  102f3d:	89 fa                	mov    %edi,%edx
  102f3f:	89 f1                	mov    %esi,%ecx
  102f41:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102f44:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102f47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102f4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102f4d:	83 c4 20             	add    $0x20,%esp
  102f50:	5e                   	pop    %esi
  102f51:	5f                   	pop    %edi
  102f52:	5d                   	pop    %ebp
  102f53:	c3                   	ret    

00102f54 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102f54:	55                   	push   %ebp
  102f55:	89 e5                	mov    %esp,%ebp
  102f57:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  102f5d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102f60:	eb 21                	jmp    102f83 <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  102f62:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f65:	0f b6 10             	movzbl (%eax),%edx
  102f68:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102f6b:	88 10                	mov    %dl,(%eax)
  102f6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102f70:	0f b6 00             	movzbl (%eax),%eax
  102f73:	84 c0                	test   %al,%al
  102f75:	74 04                	je     102f7b <strncpy+0x27>
            src ++;
  102f77:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  102f7b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102f7f:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
  102f83:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102f87:	75 d9                	jne    102f62 <strncpy+0xe>
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
  102f89:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102f8c:	c9                   	leave  
  102f8d:	c3                   	ret    

00102f8e <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102f8e:	55                   	push   %ebp
  102f8f:	89 e5                	mov    %esp,%ebp
  102f91:	57                   	push   %edi
  102f92:	56                   	push   %esi
  102f93:	83 ec 20             	sub    $0x20,%esp
  102f96:	8b 45 08             	mov    0x8(%ebp),%eax
  102f99:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102f9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCMP
#define __HAVE_ARCH_STRCMP
static inline int
__strcmp(const char *s1, const char *s2) {
    int d0, d1, ret;
    asm volatile (
  102fa2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fa5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fa8:	89 d1                	mov    %edx,%ecx
  102faa:	89 c2                	mov    %eax,%edx
  102fac:	89 ce                	mov    %ecx,%esi
  102fae:	89 d7                	mov    %edx,%edi
  102fb0:	ac                   	lods   %ds:(%esi),%al
  102fb1:	ae                   	scas   %es:(%edi),%al
  102fb2:	75 08                	jne    102fbc <strcmp+0x2e>
  102fb4:	84 c0                	test   %al,%al
  102fb6:	75 f8                	jne    102fb0 <strcmp+0x22>
  102fb8:	31 c0                	xor    %eax,%eax
  102fba:	eb 04                	jmp    102fc0 <strcmp+0x32>
  102fbc:	19 c0                	sbb    %eax,%eax
  102fbe:	0c 01                	or     $0x1,%al
  102fc0:	89 fa                	mov    %edi,%edx
  102fc2:	89 f1                	mov    %esi,%ecx
  102fc4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102fc7:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102fca:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            "orb $1, %%al;"
            "3:"
            : "=a" (ret), "=&S" (d0), "=&D" (d1)
            : "1" (s1), "2" (s2)
            : "memory");
    return ret;
  102fcd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102fd0:	83 c4 20             	add    $0x20,%esp
  102fd3:	5e                   	pop    %esi
  102fd4:	5f                   	pop    %edi
  102fd5:	5d                   	pop    %ebp
  102fd6:	c3                   	ret    

00102fd7 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102fd7:	55                   	push   %ebp
  102fd8:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102fda:	eb 0c                	jmp    102fe8 <strncmp+0x11>
        n --, s1 ++, s2 ++;
  102fdc:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102fe0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102fe4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102fe8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102fec:	74 1a                	je     103008 <strncmp+0x31>
  102fee:	8b 45 08             	mov    0x8(%ebp),%eax
  102ff1:	0f b6 00             	movzbl (%eax),%eax
  102ff4:	84 c0                	test   %al,%al
  102ff6:	74 10                	je     103008 <strncmp+0x31>
  102ff8:	8b 45 08             	mov    0x8(%ebp),%eax
  102ffb:	0f b6 10             	movzbl (%eax),%edx
  102ffe:	8b 45 0c             	mov    0xc(%ebp),%eax
  103001:	0f b6 00             	movzbl (%eax),%eax
  103004:	38 c2                	cmp    %al,%dl
  103006:	74 d4                	je     102fdc <strncmp+0x5>
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  103008:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10300c:	74 18                	je     103026 <strncmp+0x4f>
  10300e:	8b 45 08             	mov    0x8(%ebp),%eax
  103011:	0f b6 00             	movzbl (%eax),%eax
  103014:	0f b6 d0             	movzbl %al,%edx
  103017:	8b 45 0c             	mov    0xc(%ebp),%eax
  10301a:	0f b6 00             	movzbl (%eax),%eax
  10301d:	0f b6 c0             	movzbl %al,%eax
  103020:	29 c2                	sub    %eax,%edx
  103022:	89 d0                	mov    %edx,%eax
  103024:	eb 05                	jmp    10302b <strncmp+0x54>
  103026:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10302b:	5d                   	pop    %ebp
  10302c:	c3                   	ret    

0010302d <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  10302d:	55                   	push   %ebp
  10302e:	89 e5                	mov    %esp,%ebp
  103030:	83 ec 04             	sub    $0x4,%esp
  103033:	8b 45 0c             	mov    0xc(%ebp),%eax
  103036:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  103039:	eb 14                	jmp    10304f <strchr+0x22>
        if (*s == c) {
  10303b:	8b 45 08             	mov    0x8(%ebp),%eax
  10303e:	0f b6 00             	movzbl (%eax),%eax
  103041:	3a 45 fc             	cmp    -0x4(%ebp),%al
  103044:	75 05                	jne    10304b <strchr+0x1e>
            return (char *)s;
  103046:	8b 45 08             	mov    0x8(%ebp),%eax
  103049:	eb 13                	jmp    10305e <strchr+0x31>
        }
        s ++;
  10304b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
  10304f:	8b 45 08             	mov    0x8(%ebp),%eax
  103052:	0f b6 00             	movzbl (%eax),%eax
  103055:	84 c0                	test   %al,%al
  103057:	75 e2                	jne    10303b <strchr+0xe>
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
  103059:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10305e:	c9                   	leave  
  10305f:	c3                   	ret    

00103060 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  103060:	55                   	push   %ebp
  103061:	89 e5                	mov    %esp,%ebp
  103063:	83 ec 04             	sub    $0x4,%esp
  103066:	8b 45 0c             	mov    0xc(%ebp),%eax
  103069:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  10306c:	eb 11                	jmp    10307f <strfind+0x1f>
        if (*s == c) {
  10306e:	8b 45 08             	mov    0x8(%ebp),%eax
  103071:	0f b6 00             	movzbl (%eax),%eax
  103074:	3a 45 fc             	cmp    -0x4(%ebp),%al
  103077:	75 02                	jne    10307b <strfind+0x1b>
            break;
  103079:	eb 0e                	jmp    103089 <strfind+0x29>
        }
        s ++;
  10307b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
  10307f:	8b 45 08             	mov    0x8(%ebp),%eax
  103082:	0f b6 00             	movzbl (%eax),%eax
  103085:	84 c0                	test   %al,%al
  103087:	75 e5                	jne    10306e <strfind+0xe>
        if (*s == c) {
            break;
        }
        s ++;
    }
    return (char *)s;
  103089:	8b 45 08             	mov    0x8(%ebp),%eax
}
  10308c:	c9                   	leave  
  10308d:	c3                   	ret    

0010308e <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  10308e:	55                   	push   %ebp
  10308f:	89 e5                	mov    %esp,%ebp
  103091:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  103094:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  10309b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1030a2:	eb 04                	jmp    1030a8 <strtol+0x1a>
        s ++;
  1030a4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1030a8:	8b 45 08             	mov    0x8(%ebp),%eax
  1030ab:	0f b6 00             	movzbl (%eax),%eax
  1030ae:	3c 20                	cmp    $0x20,%al
  1030b0:	74 f2                	je     1030a4 <strtol+0x16>
  1030b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1030b5:	0f b6 00             	movzbl (%eax),%eax
  1030b8:	3c 09                	cmp    $0x9,%al
  1030ba:	74 e8                	je     1030a4 <strtol+0x16>
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
  1030bc:	8b 45 08             	mov    0x8(%ebp),%eax
  1030bf:	0f b6 00             	movzbl (%eax),%eax
  1030c2:	3c 2b                	cmp    $0x2b,%al
  1030c4:	75 06                	jne    1030cc <strtol+0x3e>
        s ++;
  1030c6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1030ca:	eb 15                	jmp    1030e1 <strtol+0x53>
    }
    else if (*s == '-') {
  1030cc:	8b 45 08             	mov    0x8(%ebp),%eax
  1030cf:	0f b6 00             	movzbl (%eax),%eax
  1030d2:	3c 2d                	cmp    $0x2d,%al
  1030d4:	75 0b                	jne    1030e1 <strtol+0x53>
        s ++, neg = 1;
  1030d6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1030da:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  1030e1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1030e5:	74 06                	je     1030ed <strtol+0x5f>
  1030e7:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  1030eb:	75 24                	jne    103111 <strtol+0x83>
  1030ed:	8b 45 08             	mov    0x8(%ebp),%eax
  1030f0:	0f b6 00             	movzbl (%eax),%eax
  1030f3:	3c 30                	cmp    $0x30,%al
  1030f5:	75 1a                	jne    103111 <strtol+0x83>
  1030f7:	8b 45 08             	mov    0x8(%ebp),%eax
  1030fa:	83 c0 01             	add    $0x1,%eax
  1030fd:	0f b6 00             	movzbl (%eax),%eax
  103100:	3c 78                	cmp    $0x78,%al
  103102:	75 0d                	jne    103111 <strtol+0x83>
        s += 2, base = 16;
  103104:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  103108:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  10310f:	eb 2a                	jmp    10313b <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  103111:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103115:	75 17                	jne    10312e <strtol+0xa0>
  103117:	8b 45 08             	mov    0x8(%ebp),%eax
  10311a:	0f b6 00             	movzbl (%eax),%eax
  10311d:	3c 30                	cmp    $0x30,%al
  10311f:	75 0d                	jne    10312e <strtol+0xa0>
        s ++, base = 8;
  103121:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103125:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  10312c:	eb 0d                	jmp    10313b <strtol+0xad>
    }
    else if (base == 0) {
  10312e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103132:	75 07                	jne    10313b <strtol+0xad>
        base = 10;
  103134:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  10313b:	8b 45 08             	mov    0x8(%ebp),%eax
  10313e:	0f b6 00             	movzbl (%eax),%eax
  103141:	3c 2f                	cmp    $0x2f,%al
  103143:	7e 1b                	jle    103160 <strtol+0xd2>
  103145:	8b 45 08             	mov    0x8(%ebp),%eax
  103148:	0f b6 00             	movzbl (%eax),%eax
  10314b:	3c 39                	cmp    $0x39,%al
  10314d:	7f 11                	jg     103160 <strtol+0xd2>
            dig = *s - '0';
  10314f:	8b 45 08             	mov    0x8(%ebp),%eax
  103152:	0f b6 00             	movzbl (%eax),%eax
  103155:	0f be c0             	movsbl %al,%eax
  103158:	83 e8 30             	sub    $0x30,%eax
  10315b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10315e:	eb 48                	jmp    1031a8 <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  103160:	8b 45 08             	mov    0x8(%ebp),%eax
  103163:	0f b6 00             	movzbl (%eax),%eax
  103166:	3c 60                	cmp    $0x60,%al
  103168:	7e 1b                	jle    103185 <strtol+0xf7>
  10316a:	8b 45 08             	mov    0x8(%ebp),%eax
  10316d:	0f b6 00             	movzbl (%eax),%eax
  103170:	3c 7a                	cmp    $0x7a,%al
  103172:	7f 11                	jg     103185 <strtol+0xf7>
            dig = *s - 'a' + 10;
  103174:	8b 45 08             	mov    0x8(%ebp),%eax
  103177:	0f b6 00             	movzbl (%eax),%eax
  10317a:	0f be c0             	movsbl %al,%eax
  10317d:	83 e8 57             	sub    $0x57,%eax
  103180:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103183:	eb 23                	jmp    1031a8 <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  103185:	8b 45 08             	mov    0x8(%ebp),%eax
  103188:	0f b6 00             	movzbl (%eax),%eax
  10318b:	3c 40                	cmp    $0x40,%al
  10318d:	7e 3d                	jle    1031cc <strtol+0x13e>
  10318f:	8b 45 08             	mov    0x8(%ebp),%eax
  103192:	0f b6 00             	movzbl (%eax),%eax
  103195:	3c 5a                	cmp    $0x5a,%al
  103197:	7f 33                	jg     1031cc <strtol+0x13e>
            dig = *s - 'A' + 10;
  103199:	8b 45 08             	mov    0x8(%ebp),%eax
  10319c:	0f b6 00             	movzbl (%eax),%eax
  10319f:	0f be c0             	movsbl %al,%eax
  1031a2:	83 e8 37             	sub    $0x37,%eax
  1031a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  1031a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1031ab:	3b 45 10             	cmp    0x10(%ebp),%eax
  1031ae:	7c 02                	jl     1031b2 <strtol+0x124>
            break;
  1031b0:	eb 1a                	jmp    1031cc <strtol+0x13e>
        }
        s ++, val = (val * base) + dig;
  1031b2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1031b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1031b9:	0f af 45 10          	imul   0x10(%ebp),%eax
  1031bd:	89 c2                	mov    %eax,%edx
  1031bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1031c2:	01 d0                	add    %edx,%eax
  1031c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  1031c7:	e9 6f ff ff ff       	jmp    10313b <strtol+0xad>

    if (endptr) {
  1031cc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1031d0:	74 08                	je     1031da <strtol+0x14c>
        *endptr = (char *) s;
  1031d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031d5:	8b 55 08             	mov    0x8(%ebp),%edx
  1031d8:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  1031da:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  1031de:	74 07                	je     1031e7 <strtol+0x159>
  1031e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1031e3:	f7 d8                	neg    %eax
  1031e5:	eb 03                	jmp    1031ea <strtol+0x15c>
  1031e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  1031ea:	c9                   	leave  
  1031eb:	c3                   	ret    

001031ec <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  1031ec:	55                   	push   %ebp
  1031ed:	89 e5                	mov    %esp,%ebp
  1031ef:	57                   	push   %edi
  1031f0:	83 ec 24             	sub    $0x24,%esp
  1031f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031f6:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  1031f9:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  1031fd:	8b 55 08             	mov    0x8(%ebp),%edx
  103200:	89 55 f8             	mov    %edx,-0x8(%ebp)
  103203:	88 45 f7             	mov    %al,-0x9(%ebp)
  103206:	8b 45 10             	mov    0x10(%ebp),%eax
  103209:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  10320c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  10320f:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  103213:	8b 55 f8             	mov    -0x8(%ebp),%edx
  103216:	89 d7                	mov    %edx,%edi
  103218:	f3 aa                	rep stos %al,%es:(%edi)
  10321a:	89 fa                	mov    %edi,%edx
  10321c:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  10321f:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  103222:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  103225:	83 c4 24             	add    $0x24,%esp
  103228:	5f                   	pop    %edi
  103229:	5d                   	pop    %ebp
  10322a:	c3                   	ret    

0010322b <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  10322b:	55                   	push   %ebp
  10322c:	89 e5                	mov    %esp,%ebp
  10322e:	57                   	push   %edi
  10322f:	56                   	push   %esi
  103230:	53                   	push   %ebx
  103231:	83 ec 30             	sub    $0x30,%esp
  103234:	8b 45 08             	mov    0x8(%ebp),%eax
  103237:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10323a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10323d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103240:	8b 45 10             	mov    0x10(%ebp),%eax
  103243:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  103246:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103249:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10324c:	73 42                	jae    103290 <memmove+0x65>
  10324e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103251:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103254:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103257:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10325a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10325d:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  103260:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103263:	c1 e8 02             	shr    $0x2,%eax
  103266:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  103268:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10326b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10326e:	89 d7                	mov    %edx,%edi
  103270:	89 c6                	mov    %eax,%esi
  103272:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103274:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  103277:	83 e1 03             	and    $0x3,%ecx
  10327a:	74 02                	je     10327e <memmove+0x53>
  10327c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  10327e:	89 f0                	mov    %esi,%eax
  103280:	89 fa                	mov    %edi,%edx
  103282:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  103285:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  103288:	89 45 d0             	mov    %eax,-0x30(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  10328b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10328e:	eb 36                	jmp    1032c6 <memmove+0x9b>
    asm volatile (
            "std;"
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  103290:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103293:	8d 50 ff             	lea    -0x1(%eax),%edx
  103296:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103299:	01 c2                	add    %eax,%edx
  10329b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10329e:	8d 48 ff             	lea    -0x1(%eax),%ecx
  1032a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1032a4:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
        return __memcpy(dst, src, n);
    }
    int d0, d1, d2;
    asm volatile (
  1032a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1032aa:	89 c1                	mov    %eax,%ecx
  1032ac:	89 d8                	mov    %ebx,%eax
  1032ae:	89 d6                	mov    %edx,%esi
  1032b0:	89 c7                	mov    %eax,%edi
  1032b2:	fd                   	std    
  1032b3:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1032b5:	fc                   	cld    
  1032b6:	89 f8                	mov    %edi,%eax
  1032b8:	89 f2                	mov    %esi,%edx
  1032ba:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  1032bd:	89 55 c8             	mov    %edx,-0x38(%ebp)
  1032c0:	89 45 c4             	mov    %eax,-0x3c(%ebp)
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
            : "memory");
    return dst;
  1032c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  1032c6:	83 c4 30             	add    $0x30,%esp
  1032c9:	5b                   	pop    %ebx
  1032ca:	5e                   	pop    %esi
  1032cb:	5f                   	pop    %edi
  1032cc:	5d                   	pop    %ebp
  1032cd:	c3                   	ret    

001032ce <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  1032ce:	55                   	push   %ebp
  1032cf:	89 e5                	mov    %esp,%ebp
  1032d1:	57                   	push   %edi
  1032d2:	56                   	push   %esi
  1032d3:	83 ec 20             	sub    $0x20,%esp
  1032d6:	8b 45 08             	mov    0x8(%ebp),%eax
  1032d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1032dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1032e2:	8b 45 10             	mov    0x10(%ebp),%eax
  1032e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1032e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1032eb:	c1 e8 02             	shr    $0x2,%eax
  1032ee:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  1032f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1032f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1032f6:	89 d7                	mov    %edx,%edi
  1032f8:	89 c6                	mov    %eax,%esi
  1032fa:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1032fc:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  1032ff:	83 e1 03             	and    $0x3,%ecx
  103302:	74 02                	je     103306 <memcpy+0x38>
  103304:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103306:	89 f0                	mov    %esi,%eax
  103308:	89 fa                	mov    %edi,%edx
  10330a:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  10330d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  103310:	89 45 e0             	mov    %eax,-0x20(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  103313:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  103316:	83 c4 20             	add    $0x20,%esp
  103319:	5e                   	pop    %esi
  10331a:	5f                   	pop    %edi
  10331b:	5d                   	pop    %ebp
  10331c:	c3                   	ret    

0010331d <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  10331d:	55                   	push   %ebp
  10331e:	89 e5                	mov    %esp,%ebp
  103320:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  103323:	8b 45 08             	mov    0x8(%ebp),%eax
  103326:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  103329:	8b 45 0c             	mov    0xc(%ebp),%eax
  10332c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  10332f:	eb 30                	jmp    103361 <memcmp+0x44>
        if (*s1 != *s2) {
  103331:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103334:	0f b6 10             	movzbl (%eax),%edx
  103337:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10333a:	0f b6 00             	movzbl (%eax),%eax
  10333d:	38 c2                	cmp    %al,%dl
  10333f:	74 18                	je     103359 <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  103341:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103344:	0f b6 00             	movzbl (%eax),%eax
  103347:	0f b6 d0             	movzbl %al,%edx
  10334a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10334d:	0f b6 00             	movzbl (%eax),%eax
  103350:	0f b6 c0             	movzbl %al,%eax
  103353:	29 c2                	sub    %eax,%edx
  103355:	89 d0                	mov    %edx,%eax
  103357:	eb 1a                	jmp    103373 <memcmp+0x56>
        }
        s1 ++, s2 ++;
  103359:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10335d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
  103361:	8b 45 10             	mov    0x10(%ebp),%eax
  103364:	8d 50 ff             	lea    -0x1(%eax),%edx
  103367:	89 55 10             	mov    %edx,0x10(%ebp)
  10336a:	85 c0                	test   %eax,%eax
  10336c:	75 c3                	jne    103331 <memcmp+0x14>
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
  10336e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103373:	c9                   	leave  
  103374:	c3                   	ret    
