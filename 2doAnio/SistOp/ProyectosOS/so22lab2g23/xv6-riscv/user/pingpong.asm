
user/_pingpong:     formato del fichero elf64-littleriscv


Desensamblado de la sección .text:

0000000000000000 <main>:
#include "../kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(int argc, char **argv)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	e05a                	sd	s6,0(sp)
  12:	0080                	addi	s0,sp,64
    if (argc != 2)
  14:	4789                	li	a5,2
  16:	02f50763          	beq	a0,a5,44 <main+0x44>
  1a:	84aa                	mv	s1,a0
    {
        printf("error invalid arguments\n");
  1c:	00001517          	auipc	a0,0x1
  20:	8c450513          	addi	a0,a0,-1852 # 8e0 <malloc+0xf2>
  24:	00000097          	auipc	ra,0x0
  28:	70c080e7          	jalr	1804(ra) # 730 <printf>

        if (argc == 1)
  2c:	4785                	li	a5,1
  2e:	0cf49263          	bne	s1,a5,f2 <main+0xf2>
        {
            printf("please re-run entering the rally number\n ");
  32:	00001517          	auipc	a0,0x1
  36:	8ce50513          	addi	a0,a0,-1842 # 900 <malloc+0x112>
  3a:	00000097          	auipc	ra,0x0
  3e:	6f6080e7          	jalr	1782(ra) # 730 <printf>
  42:	a845                	j	f2 <main+0xf2>
        }

        return 0;
    }
    int N = atoi(argv[1]);
  44:	6588                	ld	a0,8(a1)
  46:	00000097          	auipc	ra,0x0
  4a:	252080e7          	jalr	594(ra) # 298 <atoi>
  4e:	89aa                	mv	s3,a0
    int id = 0;
    
    id = sem_open(id, 1 );
  50:	4585                	li	a1,1
  52:	4501                	li	a0,0
  54:	00000097          	auipc	ra,0x0
  58:	3e4080e7          	jalr	996(ra) # 438 <sem_open>
  5c:	892a                	mv	s2,a0

    int pid = fork();
  5e:	00000097          	auipc	ra,0x0
  62:	332080e7          	jalr	818(ra) # 390 <fork>
  66:	8a2a                	mv	s4,a0

    for (unsigned int i = 0; i < N; i++)
  68:	2981                	sext.w	s3,s3
  6a:	06098a63          	beqz	s3,de <main+0xde>
  6e:	4481                	li	s1,0
        else
        {
            // father

            sem_down(id);
            printf("PING\n");
  70:	00001b17          	auipc	s6,0x1
  74:	8c8b0b13          	addi	s6,s6,-1848 # 938 <malloc+0x14a>
            printf("\t\tPONG\n");
  78:	00001a97          	auipc	s5,0x1
  7c:	8b8a8a93          	addi	s5,s5,-1864 # 930 <malloc+0x142>
  80:	a805                	j	b0 <main+0xb0>
            sem_down(id);
  82:	854a                	mv	a0,s2
  84:	00000097          	auipc	ra,0x0
  88:	3cc080e7          	jalr	972(ra) # 450 <sem_down>
            printf("PING\n");
  8c:	855a                	mv	a0,s6
  8e:	00000097          	auipc	ra,0x0
  92:	6a2080e7          	jalr	1698(ra) # 730 <printf>
            sleep(1);
  96:	4505                	li	a0,1
  98:	00000097          	auipc	ra,0x0
  9c:	390080e7          	jalr	912(ra) # 428 <sleep>
            sem_up(id);
  a0:	854a                	mv	a0,s2
  a2:	00000097          	auipc	ra,0x0
  a6:	3a6080e7          	jalr	934(ra) # 448 <sem_up>
    for (unsigned int i = 0; i < N; i++)
  aa:	2485                	addiw	s1,s1,1
  ac:	03348963          	beq	s1,s3,de <main+0xde>
        if (pid == 0)
  b0:	fc0a19e3          	bnez	s4,82 <main+0x82>
            sem_down(id);
  b4:	854a                	mv	a0,s2
  b6:	00000097          	auipc	ra,0x0
  ba:	39a080e7          	jalr	922(ra) # 450 <sem_down>
            printf("\t\tPONG\n");
  be:	8556                	mv	a0,s5
  c0:	00000097          	auipc	ra,0x0
  c4:	670080e7          	jalr	1648(ra) # 730 <printf>
            sleep(1);
  c8:	4505                	li	a0,1
  ca:	00000097          	auipc	ra,0x0
  ce:	35e080e7          	jalr	862(ra) # 428 <sleep>
            sem_up(id);
  d2:	854a                	mv	a0,s2
  d4:	00000097          	auipc	ra,0x0
  d8:	374080e7          	jalr	884(ra) # 448 <sem_up>
  dc:	b7f9                	j	aa <main+0xaa>
        }
    }
    sleep(1);
  de:	4505                	li	a0,1
  e0:	00000097          	auipc	ra,0x0
  e4:	348080e7          	jalr	840(ra) # 428 <sleep>
    sem_close(id);
  e8:	854a                	mv	a0,s2
  ea:	00000097          	auipc	ra,0x0
  ee:	356080e7          	jalr	854(ra) # 440 <sem_close>

    return 0;
  f2:	4501                	li	a0,0
  f4:	70e2                	ld	ra,56(sp)
  f6:	7442                	ld	s0,48(sp)
  f8:	74a2                	ld	s1,40(sp)
  fa:	7902                	ld	s2,32(sp)
  fc:	69e2                	ld	s3,24(sp)
  fe:	6a42                	ld	s4,16(sp)
 100:	6aa2                	ld	s5,8(sp)
 102:	6b02                	ld	s6,0(sp)
 104:	6121                	addi	sp,sp,64
 106:	8082                	ret

0000000000000108 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 108:	1141                	addi	sp,sp,-16
 10a:	e406                	sd	ra,8(sp)
 10c:	e022                	sd	s0,0(sp)
 10e:	0800                	addi	s0,sp,16
  extern int main();
  main();
 110:	00000097          	auipc	ra,0x0
 114:	ef0080e7          	jalr	-272(ra) # 0 <main>
  exit(0);
 118:	4501                	li	a0,0
 11a:	00000097          	auipc	ra,0x0
 11e:	27e080e7          	jalr	638(ra) # 398 <exit>

0000000000000122 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 122:	1141                	addi	sp,sp,-16
 124:	e422                	sd	s0,8(sp)
 126:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 128:	87aa                	mv	a5,a0
 12a:	0585                	addi	a1,a1,1
 12c:	0785                	addi	a5,a5,1
 12e:	fff5c703          	lbu	a4,-1(a1)
 132:	fee78fa3          	sb	a4,-1(a5)
 136:	fb75                	bnez	a4,12a <strcpy+0x8>
    ;
  return os;
}
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret

000000000000013e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13e:	1141                	addi	sp,sp,-16
 140:	e422                	sd	s0,8(sp)
 142:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 144:	00054783          	lbu	a5,0(a0)
 148:	cb91                	beqz	a5,15c <strcmp+0x1e>
 14a:	0005c703          	lbu	a4,0(a1)
 14e:	00f71763          	bne	a4,a5,15c <strcmp+0x1e>
    p++, q++;
 152:	0505                	addi	a0,a0,1
 154:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 156:	00054783          	lbu	a5,0(a0)
 15a:	fbe5                	bnez	a5,14a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 15c:	0005c503          	lbu	a0,0(a1)
}
 160:	40a7853b          	subw	a0,a5,a0
 164:	6422                	ld	s0,8(sp)
 166:	0141                	addi	sp,sp,16
 168:	8082                	ret

000000000000016a <strlen>:

uint
strlen(const char *s)
{
 16a:	1141                	addi	sp,sp,-16
 16c:	e422                	sd	s0,8(sp)
 16e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 170:	00054783          	lbu	a5,0(a0)
 174:	cf91                	beqz	a5,190 <strlen+0x26>
 176:	0505                	addi	a0,a0,1
 178:	87aa                	mv	a5,a0
 17a:	4685                	li	a3,1
 17c:	9e89                	subw	a3,a3,a0
 17e:	00f6853b          	addw	a0,a3,a5
 182:	0785                	addi	a5,a5,1
 184:	fff7c703          	lbu	a4,-1(a5)
 188:	fb7d                	bnez	a4,17e <strlen+0x14>
    ;
  return n;
}
 18a:	6422                	ld	s0,8(sp)
 18c:	0141                	addi	sp,sp,16
 18e:	8082                	ret
  for(n = 0; s[n]; n++)
 190:	4501                	li	a0,0
 192:	bfe5                	j	18a <strlen+0x20>

0000000000000194 <memset>:

void*
memset(void *dst, int c, uint n)
{
 194:	1141                	addi	sp,sp,-16
 196:	e422                	sd	s0,8(sp)
 198:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 19a:	ce09                	beqz	a2,1b4 <memset+0x20>
 19c:	87aa                	mv	a5,a0
 19e:	fff6071b          	addiw	a4,a2,-1
 1a2:	1702                	slli	a4,a4,0x20
 1a4:	9301                	srli	a4,a4,0x20
 1a6:	0705                	addi	a4,a4,1
 1a8:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1aa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ae:	0785                	addi	a5,a5,1
 1b0:	fee79de3          	bne	a5,a4,1aa <memset+0x16>
  }
  return dst;
}
 1b4:	6422                	ld	s0,8(sp)
 1b6:	0141                	addi	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strchr>:

char*
strchr(const char *s, char c)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e422                	sd	s0,8(sp)
 1be:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	cb99                	beqz	a5,1da <strchr+0x20>
    if(*s == c)
 1c6:	00f58763          	beq	a1,a5,1d4 <strchr+0x1a>
  for(; *s; s++)
 1ca:	0505                	addi	a0,a0,1
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	fbfd                	bnez	a5,1c6 <strchr+0xc>
      return (char*)s;
  return 0;
 1d2:	4501                	li	a0,0
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret
  return 0;
 1da:	4501                	li	a0,0
 1dc:	bfe5                	j	1d4 <strchr+0x1a>

00000000000001de <gets>:

char*
gets(char *buf, int max)
{
 1de:	711d                	addi	sp,sp,-96
 1e0:	ec86                	sd	ra,88(sp)
 1e2:	e8a2                	sd	s0,80(sp)
 1e4:	e4a6                	sd	s1,72(sp)
 1e6:	e0ca                	sd	s2,64(sp)
 1e8:	fc4e                	sd	s3,56(sp)
 1ea:	f852                	sd	s4,48(sp)
 1ec:	f456                	sd	s5,40(sp)
 1ee:	f05a                	sd	s6,32(sp)
 1f0:	ec5e                	sd	s7,24(sp)
 1f2:	1080                	addi	s0,sp,96
 1f4:	8baa                	mv	s7,a0
 1f6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f8:	892a                	mv	s2,a0
 1fa:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1fc:	4aa9                	li	s5,10
 1fe:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 200:	89a6                	mv	s3,s1
 202:	2485                	addiw	s1,s1,1
 204:	0344d863          	bge	s1,s4,234 <gets+0x56>
    cc = read(0, &c, 1);
 208:	4605                	li	a2,1
 20a:	faf40593          	addi	a1,s0,-81
 20e:	4501                	li	a0,0
 210:	00000097          	auipc	ra,0x0
 214:	1a0080e7          	jalr	416(ra) # 3b0 <read>
    if(cc < 1)
 218:	00a05e63          	blez	a0,234 <gets+0x56>
    buf[i++] = c;
 21c:	faf44783          	lbu	a5,-81(s0)
 220:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 224:	01578763          	beq	a5,s5,232 <gets+0x54>
 228:	0905                	addi	s2,s2,1
 22a:	fd679be3          	bne	a5,s6,200 <gets+0x22>
  for(i=0; i+1 < max; ){
 22e:	89a6                	mv	s3,s1
 230:	a011                	j	234 <gets+0x56>
 232:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 234:	99de                	add	s3,s3,s7
 236:	00098023          	sb	zero,0(s3)
  return buf;
}
 23a:	855e                	mv	a0,s7
 23c:	60e6                	ld	ra,88(sp)
 23e:	6446                	ld	s0,80(sp)
 240:	64a6                	ld	s1,72(sp)
 242:	6906                	ld	s2,64(sp)
 244:	79e2                	ld	s3,56(sp)
 246:	7a42                	ld	s4,48(sp)
 248:	7aa2                	ld	s5,40(sp)
 24a:	7b02                	ld	s6,32(sp)
 24c:	6be2                	ld	s7,24(sp)
 24e:	6125                	addi	sp,sp,96
 250:	8082                	ret

0000000000000252 <stat>:

int
stat(const char *n, struct stat *st)
{
 252:	1101                	addi	sp,sp,-32
 254:	ec06                	sd	ra,24(sp)
 256:	e822                	sd	s0,16(sp)
 258:	e426                	sd	s1,8(sp)
 25a:	e04a                	sd	s2,0(sp)
 25c:	1000                	addi	s0,sp,32
 25e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 260:	4581                	li	a1,0
 262:	00000097          	auipc	ra,0x0
 266:	176080e7          	jalr	374(ra) # 3d8 <open>
  if(fd < 0)
 26a:	02054563          	bltz	a0,294 <stat+0x42>
 26e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 270:	85ca                	mv	a1,s2
 272:	00000097          	auipc	ra,0x0
 276:	17e080e7          	jalr	382(ra) # 3f0 <fstat>
 27a:	892a                	mv	s2,a0
  close(fd);
 27c:	8526                	mv	a0,s1
 27e:	00000097          	auipc	ra,0x0
 282:	142080e7          	jalr	322(ra) # 3c0 <close>
  return r;
}
 286:	854a                	mv	a0,s2
 288:	60e2                	ld	ra,24(sp)
 28a:	6442                	ld	s0,16(sp)
 28c:	64a2                	ld	s1,8(sp)
 28e:	6902                	ld	s2,0(sp)
 290:	6105                	addi	sp,sp,32
 292:	8082                	ret
    return -1;
 294:	597d                	li	s2,-1
 296:	bfc5                	j	286 <stat+0x34>

0000000000000298 <atoi>:

int
atoi(const char *s)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e422                	sd	s0,8(sp)
 29c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29e:	00054603          	lbu	a2,0(a0)
 2a2:	fd06079b          	addiw	a5,a2,-48
 2a6:	0ff7f793          	andi	a5,a5,255
 2aa:	4725                	li	a4,9
 2ac:	02f76963          	bltu	a4,a5,2de <atoi+0x46>
 2b0:	86aa                	mv	a3,a0
  n = 0;
 2b2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2b4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2b6:	0685                	addi	a3,a3,1
 2b8:	0025179b          	slliw	a5,a0,0x2
 2bc:	9fa9                	addw	a5,a5,a0
 2be:	0017979b          	slliw	a5,a5,0x1
 2c2:	9fb1                	addw	a5,a5,a2
 2c4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c8:	0006c603          	lbu	a2,0(a3)
 2cc:	fd06071b          	addiw	a4,a2,-48
 2d0:	0ff77713          	andi	a4,a4,255
 2d4:	fee5f1e3          	bgeu	a1,a4,2b6 <atoi+0x1e>
  return n;
}
 2d8:	6422                	ld	s0,8(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret
  n = 0;
 2de:	4501                	li	a0,0
 2e0:	bfe5                	j	2d8 <atoi+0x40>

00000000000002e2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e2:	1141                	addi	sp,sp,-16
 2e4:	e422                	sd	s0,8(sp)
 2e6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e8:	02b57663          	bgeu	a0,a1,314 <memmove+0x32>
    while(n-- > 0)
 2ec:	02c05163          	blez	a2,30e <memmove+0x2c>
 2f0:	fff6079b          	addiw	a5,a2,-1
 2f4:	1782                	slli	a5,a5,0x20
 2f6:	9381                	srli	a5,a5,0x20
 2f8:	0785                	addi	a5,a5,1
 2fa:	97aa                	add	a5,a5,a0
  dst = vdst;
 2fc:	872a                	mv	a4,a0
      *dst++ = *src++;
 2fe:	0585                	addi	a1,a1,1
 300:	0705                	addi	a4,a4,1
 302:	fff5c683          	lbu	a3,-1(a1)
 306:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 30a:	fee79ae3          	bne	a5,a4,2fe <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 30e:	6422                	ld	s0,8(sp)
 310:	0141                	addi	sp,sp,16
 312:	8082                	ret
    dst += n;
 314:	00c50733          	add	a4,a0,a2
    src += n;
 318:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 31a:	fec05ae3          	blez	a2,30e <memmove+0x2c>
 31e:	fff6079b          	addiw	a5,a2,-1
 322:	1782                	slli	a5,a5,0x20
 324:	9381                	srli	a5,a5,0x20
 326:	fff7c793          	not	a5,a5
 32a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 32c:	15fd                	addi	a1,a1,-1
 32e:	177d                	addi	a4,a4,-1
 330:	0005c683          	lbu	a3,0(a1)
 334:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 338:	fee79ae3          	bne	a5,a4,32c <memmove+0x4a>
 33c:	bfc9                	j	30e <memmove+0x2c>

000000000000033e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e422                	sd	s0,8(sp)
 342:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 344:	ca05                	beqz	a2,374 <memcmp+0x36>
 346:	fff6069b          	addiw	a3,a2,-1
 34a:	1682                	slli	a3,a3,0x20
 34c:	9281                	srli	a3,a3,0x20
 34e:	0685                	addi	a3,a3,1
 350:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 352:	00054783          	lbu	a5,0(a0)
 356:	0005c703          	lbu	a4,0(a1)
 35a:	00e79863          	bne	a5,a4,36a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 35e:	0505                	addi	a0,a0,1
    p2++;
 360:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 362:	fed518e3          	bne	a0,a3,352 <memcmp+0x14>
  }
  return 0;
 366:	4501                	li	a0,0
 368:	a019                	j	36e <memcmp+0x30>
      return *p1 - *p2;
 36a:	40e7853b          	subw	a0,a5,a4
}
 36e:	6422                	ld	s0,8(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret
  return 0;
 374:	4501                	li	a0,0
 376:	bfe5                	j	36e <memcmp+0x30>

0000000000000378 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e406                	sd	ra,8(sp)
 37c:	e022                	sd	s0,0(sp)
 37e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 380:	00000097          	auipc	ra,0x0
 384:	f62080e7          	jalr	-158(ra) # 2e2 <memmove>
}
 388:	60a2                	ld	ra,8(sp)
 38a:	6402                	ld	s0,0(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret

0000000000000390 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 390:	4885                	li	a7,1
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <exit>:
.global exit
exit:
 li a7, SYS_exit
 398:	4889                	li	a7,2
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3a0:	488d                	li	a7,3
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3a8:	4891                	li	a7,4
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <read>:
.global read
read:
 li a7, SYS_read
 3b0:	4895                	li	a7,5
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <write>:
.global write
write:
 li a7, SYS_write
 3b8:	48c1                	li	a7,16
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <close>:
.global close
close:
 li a7, SYS_close
 3c0:	48d5                	li	a7,21
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3c8:	4899                	li	a7,6
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3d0:	489d                	li	a7,7
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <open>:
.global open
open:
 li a7, SYS_open
 3d8:	48bd                	li	a7,15
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3e0:	48c5                	li	a7,17
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3e8:	48c9                	li	a7,18
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3f0:	48a1                	li	a7,8
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <link>:
.global link
link:
 li a7, SYS_link
 3f8:	48cd                	li	a7,19
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 400:	48d1                	li	a7,20
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 408:	48a5                	li	a7,9
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <dup>:
.global dup
dup:
 li a7, SYS_dup
 410:	48a9                	li	a7,10
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 418:	48ad                	li	a7,11
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 420:	48b1                	li	a7,12
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 428:	48b5                	li	a7,13
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 430:	48b9                	li	a7,14
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 438:	48d9                	li	a7,22
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 440:	48dd                	li	a7,23
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <sem_up>:
.global sem_up
sem_up:
 li a7, SYS_sem_up
 448:	48d9                	li	a7,22
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <sem_down>:
.global sem_down
sem_down:
 li a7, SYS_sem_down
 450:	48e5                	li	a7,25
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 458:	1101                	addi	sp,sp,-32
 45a:	ec06                	sd	ra,24(sp)
 45c:	e822                	sd	s0,16(sp)
 45e:	1000                	addi	s0,sp,32
 460:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 464:	4605                	li	a2,1
 466:	fef40593          	addi	a1,s0,-17
 46a:	00000097          	auipc	ra,0x0
 46e:	f4e080e7          	jalr	-178(ra) # 3b8 <write>
}
 472:	60e2                	ld	ra,24(sp)
 474:	6442                	ld	s0,16(sp)
 476:	6105                	addi	sp,sp,32
 478:	8082                	ret

000000000000047a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 47a:	7139                	addi	sp,sp,-64
 47c:	fc06                	sd	ra,56(sp)
 47e:	f822                	sd	s0,48(sp)
 480:	f426                	sd	s1,40(sp)
 482:	f04a                	sd	s2,32(sp)
 484:	ec4e                	sd	s3,24(sp)
 486:	0080                	addi	s0,sp,64
 488:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 48a:	c299                	beqz	a3,490 <printint+0x16>
 48c:	0805c863          	bltz	a1,51c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 490:	2581                	sext.w	a1,a1
  neg = 0;
 492:	4881                	li	a7,0
 494:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 498:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 49a:	2601                	sext.w	a2,a2
 49c:	00000517          	auipc	a0,0x0
 4a0:	4ac50513          	addi	a0,a0,1196 # 948 <digits>
 4a4:	883a                	mv	a6,a4
 4a6:	2705                	addiw	a4,a4,1
 4a8:	02c5f7bb          	remuw	a5,a1,a2
 4ac:	1782                	slli	a5,a5,0x20
 4ae:	9381                	srli	a5,a5,0x20
 4b0:	97aa                	add	a5,a5,a0
 4b2:	0007c783          	lbu	a5,0(a5)
 4b6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4ba:	0005879b          	sext.w	a5,a1
 4be:	02c5d5bb          	divuw	a1,a1,a2
 4c2:	0685                	addi	a3,a3,1
 4c4:	fec7f0e3          	bgeu	a5,a2,4a4 <printint+0x2a>
  if(neg)
 4c8:	00088b63          	beqz	a7,4de <printint+0x64>
    buf[i++] = '-';
 4cc:	fd040793          	addi	a5,s0,-48
 4d0:	973e                	add	a4,a4,a5
 4d2:	02d00793          	li	a5,45
 4d6:	fef70823          	sb	a5,-16(a4)
 4da:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4de:	02e05863          	blez	a4,50e <printint+0x94>
 4e2:	fc040793          	addi	a5,s0,-64
 4e6:	00e78933          	add	s2,a5,a4
 4ea:	fff78993          	addi	s3,a5,-1
 4ee:	99ba                	add	s3,s3,a4
 4f0:	377d                	addiw	a4,a4,-1
 4f2:	1702                	slli	a4,a4,0x20
 4f4:	9301                	srli	a4,a4,0x20
 4f6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4fa:	fff94583          	lbu	a1,-1(s2)
 4fe:	8526                	mv	a0,s1
 500:	00000097          	auipc	ra,0x0
 504:	f58080e7          	jalr	-168(ra) # 458 <putc>
  while(--i >= 0)
 508:	197d                	addi	s2,s2,-1
 50a:	ff3918e3          	bne	s2,s3,4fa <printint+0x80>
}
 50e:	70e2                	ld	ra,56(sp)
 510:	7442                	ld	s0,48(sp)
 512:	74a2                	ld	s1,40(sp)
 514:	7902                	ld	s2,32(sp)
 516:	69e2                	ld	s3,24(sp)
 518:	6121                	addi	sp,sp,64
 51a:	8082                	ret
    x = -xx;
 51c:	40b005bb          	negw	a1,a1
    neg = 1;
 520:	4885                	li	a7,1
    x = -xx;
 522:	bf8d                	j	494 <printint+0x1a>

0000000000000524 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 524:	7119                	addi	sp,sp,-128
 526:	fc86                	sd	ra,120(sp)
 528:	f8a2                	sd	s0,112(sp)
 52a:	f4a6                	sd	s1,104(sp)
 52c:	f0ca                	sd	s2,96(sp)
 52e:	ecce                	sd	s3,88(sp)
 530:	e8d2                	sd	s4,80(sp)
 532:	e4d6                	sd	s5,72(sp)
 534:	e0da                	sd	s6,64(sp)
 536:	fc5e                	sd	s7,56(sp)
 538:	f862                	sd	s8,48(sp)
 53a:	f466                	sd	s9,40(sp)
 53c:	f06a                	sd	s10,32(sp)
 53e:	ec6e                	sd	s11,24(sp)
 540:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 542:	0005c903          	lbu	s2,0(a1)
 546:	18090f63          	beqz	s2,6e4 <vprintf+0x1c0>
 54a:	8aaa                	mv	s5,a0
 54c:	8b32                	mv	s6,a2
 54e:	00158493          	addi	s1,a1,1
  state = 0;
 552:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 554:	02500a13          	li	s4,37
      if(c == 'd'){
 558:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 55c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 560:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 564:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 568:	00000b97          	auipc	s7,0x0
 56c:	3e0b8b93          	addi	s7,s7,992 # 948 <digits>
 570:	a839                	j	58e <vprintf+0x6a>
        putc(fd, c);
 572:	85ca                	mv	a1,s2
 574:	8556                	mv	a0,s5
 576:	00000097          	auipc	ra,0x0
 57a:	ee2080e7          	jalr	-286(ra) # 458 <putc>
 57e:	a019                	j	584 <vprintf+0x60>
    } else if(state == '%'){
 580:	01498f63          	beq	s3,s4,59e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 584:	0485                	addi	s1,s1,1
 586:	fff4c903          	lbu	s2,-1(s1)
 58a:	14090d63          	beqz	s2,6e4 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 58e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 592:	fe0997e3          	bnez	s3,580 <vprintf+0x5c>
      if(c == '%'){
 596:	fd479ee3          	bne	a5,s4,572 <vprintf+0x4e>
        state = '%';
 59a:	89be                	mv	s3,a5
 59c:	b7e5                	j	584 <vprintf+0x60>
      if(c == 'd'){
 59e:	05878063          	beq	a5,s8,5de <vprintf+0xba>
      } else if(c == 'l') {
 5a2:	05978c63          	beq	a5,s9,5fa <vprintf+0xd6>
      } else if(c == 'x') {
 5a6:	07a78863          	beq	a5,s10,616 <vprintf+0xf2>
      } else if(c == 'p') {
 5aa:	09b78463          	beq	a5,s11,632 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 5ae:	07300713          	li	a4,115
 5b2:	0ce78663          	beq	a5,a4,67e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5b6:	06300713          	li	a4,99
 5ba:	0ee78e63          	beq	a5,a4,6b6 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 5be:	11478863          	beq	a5,s4,6ce <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5c2:	85d2                	mv	a1,s4
 5c4:	8556                	mv	a0,s5
 5c6:	00000097          	auipc	ra,0x0
 5ca:	e92080e7          	jalr	-366(ra) # 458 <putc>
        putc(fd, c);
 5ce:	85ca                	mv	a1,s2
 5d0:	8556                	mv	a0,s5
 5d2:	00000097          	auipc	ra,0x0
 5d6:	e86080e7          	jalr	-378(ra) # 458 <putc>
      }
      state = 0;
 5da:	4981                	li	s3,0
 5dc:	b765                	j	584 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5de:	008b0913          	addi	s2,s6,8
 5e2:	4685                	li	a3,1
 5e4:	4629                	li	a2,10
 5e6:	000b2583          	lw	a1,0(s6)
 5ea:	8556                	mv	a0,s5
 5ec:	00000097          	auipc	ra,0x0
 5f0:	e8e080e7          	jalr	-370(ra) # 47a <printint>
 5f4:	8b4a                	mv	s6,s2
      state = 0;
 5f6:	4981                	li	s3,0
 5f8:	b771                	j	584 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5fa:	008b0913          	addi	s2,s6,8
 5fe:	4681                	li	a3,0
 600:	4629                	li	a2,10
 602:	000b2583          	lw	a1,0(s6)
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	e72080e7          	jalr	-398(ra) # 47a <printint>
 610:	8b4a                	mv	s6,s2
      state = 0;
 612:	4981                	li	s3,0
 614:	bf85                	j	584 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 616:	008b0913          	addi	s2,s6,8
 61a:	4681                	li	a3,0
 61c:	4641                	li	a2,16
 61e:	000b2583          	lw	a1,0(s6)
 622:	8556                	mv	a0,s5
 624:	00000097          	auipc	ra,0x0
 628:	e56080e7          	jalr	-426(ra) # 47a <printint>
 62c:	8b4a                	mv	s6,s2
      state = 0;
 62e:	4981                	li	s3,0
 630:	bf91                	j	584 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 632:	008b0793          	addi	a5,s6,8
 636:	f8f43423          	sd	a5,-120(s0)
 63a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 63e:	03000593          	li	a1,48
 642:	8556                	mv	a0,s5
 644:	00000097          	auipc	ra,0x0
 648:	e14080e7          	jalr	-492(ra) # 458 <putc>
  putc(fd, 'x');
 64c:	85ea                	mv	a1,s10
 64e:	8556                	mv	a0,s5
 650:	00000097          	auipc	ra,0x0
 654:	e08080e7          	jalr	-504(ra) # 458 <putc>
 658:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 65a:	03c9d793          	srli	a5,s3,0x3c
 65e:	97de                	add	a5,a5,s7
 660:	0007c583          	lbu	a1,0(a5)
 664:	8556                	mv	a0,s5
 666:	00000097          	auipc	ra,0x0
 66a:	df2080e7          	jalr	-526(ra) # 458 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 66e:	0992                	slli	s3,s3,0x4
 670:	397d                	addiw	s2,s2,-1
 672:	fe0914e3          	bnez	s2,65a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 676:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 67a:	4981                	li	s3,0
 67c:	b721                	j	584 <vprintf+0x60>
        s = va_arg(ap, char*);
 67e:	008b0993          	addi	s3,s6,8
 682:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 686:	02090163          	beqz	s2,6a8 <vprintf+0x184>
        while(*s != 0){
 68a:	00094583          	lbu	a1,0(s2)
 68e:	c9a1                	beqz	a1,6de <vprintf+0x1ba>
          putc(fd, *s);
 690:	8556                	mv	a0,s5
 692:	00000097          	auipc	ra,0x0
 696:	dc6080e7          	jalr	-570(ra) # 458 <putc>
          s++;
 69a:	0905                	addi	s2,s2,1
        while(*s != 0){
 69c:	00094583          	lbu	a1,0(s2)
 6a0:	f9e5                	bnez	a1,690 <vprintf+0x16c>
        s = va_arg(ap, char*);
 6a2:	8b4e                	mv	s6,s3
      state = 0;
 6a4:	4981                	li	s3,0
 6a6:	bdf9                	j	584 <vprintf+0x60>
          s = "(null)";
 6a8:	00000917          	auipc	s2,0x0
 6ac:	29890913          	addi	s2,s2,664 # 940 <malloc+0x152>
        while(*s != 0){
 6b0:	02800593          	li	a1,40
 6b4:	bff1                	j	690 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 6b6:	008b0913          	addi	s2,s6,8
 6ba:	000b4583          	lbu	a1,0(s6)
 6be:	8556                	mv	a0,s5
 6c0:	00000097          	auipc	ra,0x0
 6c4:	d98080e7          	jalr	-616(ra) # 458 <putc>
 6c8:	8b4a                	mv	s6,s2
      state = 0;
 6ca:	4981                	li	s3,0
 6cc:	bd65                	j	584 <vprintf+0x60>
        putc(fd, c);
 6ce:	85d2                	mv	a1,s4
 6d0:	8556                	mv	a0,s5
 6d2:	00000097          	auipc	ra,0x0
 6d6:	d86080e7          	jalr	-634(ra) # 458 <putc>
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	b565                	j	584 <vprintf+0x60>
        s = va_arg(ap, char*);
 6de:	8b4e                	mv	s6,s3
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	b54d                	j	584 <vprintf+0x60>
    }
  }
}
 6e4:	70e6                	ld	ra,120(sp)
 6e6:	7446                	ld	s0,112(sp)
 6e8:	74a6                	ld	s1,104(sp)
 6ea:	7906                	ld	s2,96(sp)
 6ec:	69e6                	ld	s3,88(sp)
 6ee:	6a46                	ld	s4,80(sp)
 6f0:	6aa6                	ld	s5,72(sp)
 6f2:	6b06                	ld	s6,64(sp)
 6f4:	7be2                	ld	s7,56(sp)
 6f6:	7c42                	ld	s8,48(sp)
 6f8:	7ca2                	ld	s9,40(sp)
 6fa:	7d02                	ld	s10,32(sp)
 6fc:	6de2                	ld	s11,24(sp)
 6fe:	6109                	addi	sp,sp,128
 700:	8082                	ret

0000000000000702 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 702:	715d                	addi	sp,sp,-80
 704:	ec06                	sd	ra,24(sp)
 706:	e822                	sd	s0,16(sp)
 708:	1000                	addi	s0,sp,32
 70a:	e010                	sd	a2,0(s0)
 70c:	e414                	sd	a3,8(s0)
 70e:	e818                	sd	a4,16(s0)
 710:	ec1c                	sd	a5,24(s0)
 712:	03043023          	sd	a6,32(s0)
 716:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 71a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 71e:	8622                	mv	a2,s0
 720:	00000097          	auipc	ra,0x0
 724:	e04080e7          	jalr	-508(ra) # 524 <vprintf>
}
 728:	60e2                	ld	ra,24(sp)
 72a:	6442                	ld	s0,16(sp)
 72c:	6161                	addi	sp,sp,80
 72e:	8082                	ret

0000000000000730 <printf>:

void
printf(const char *fmt, ...)
{
 730:	711d                	addi	sp,sp,-96
 732:	ec06                	sd	ra,24(sp)
 734:	e822                	sd	s0,16(sp)
 736:	1000                	addi	s0,sp,32
 738:	e40c                	sd	a1,8(s0)
 73a:	e810                	sd	a2,16(s0)
 73c:	ec14                	sd	a3,24(s0)
 73e:	f018                	sd	a4,32(s0)
 740:	f41c                	sd	a5,40(s0)
 742:	03043823          	sd	a6,48(s0)
 746:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 74a:	00840613          	addi	a2,s0,8
 74e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 752:	85aa                	mv	a1,a0
 754:	4505                	li	a0,1
 756:	00000097          	auipc	ra,0x0
 75a:	dce080e7          	jalr	-562(ra) # 524 <vprintf>
}
 75e:	60e2                	ld	ra,24(sp)
 760:	6442                	ld	s0,16(sp)
 762:	6125                	addi	sp,sp,96
 764:	8082                	ret

0000000000000766 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 766:	1141                	addi	sp,sp,-16
 768:	e422                	sd	s0,8(sp)
 76a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 76c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 770:	00001797          	auipc	a5,0x1
 774:	8907b783          	ld	a5,-1904(a5) # 1000 <freep>
 778:	a805                	j	7a8 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 77a:	4618                	lw	a4,8(a2)
 77c:	9db9                	addw	a1,a1,a4
 77e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 782:	6398                	ld	a4,0(a5)
 784:	6318                	ld	a4,0(a4)
 786:	fee53823          	sd	a4,-16(a0)
 78a:	a091                	j	7ce <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 78c:	ff852703          	lw	a4,-8(a0)
 790:	9e39                	addw	a2,a2,a4
 792:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 794:	ff053703          	ld	a4,-16(a0)
 798:	e398                	sd	a4,0(a5)
 79a:	a099                	j	7e0 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79c:	6398                	ld	a4,0(a5)
 79e:	00e7e463          	bltu	a5,a4,7a6 <free+0x40>
 7a2:	00e6ea63          	bltu	a3,a4,7b6 <free+0x50>
{
 7a6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a8:	fed7fae3          	bgeu	a5,a3,79c <free+0x36>
 7ac:	6398                	ld	a4,0(a5)
 7ae:	00e6e463          	bltu	a3,a4,7b6 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b2:	fee7eae3          	bltu	a5,a4,7a6 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 7b6:	ff852583          	lw	a1,-8(a0)
 7ba:	6390                	ld	a2,0(a5)
 7bc:	02059713          	slli	a4,a1,0x20
 7c0:	9301                	srli	a4,a4,0x20
 7c2:	0712                	slli	a4,a4,0x4
 7c4:	9736                	add	a4,a4,a3
 7c6:	fae60ae3          	beq	a2,a4,77a <free+0x14>
    bp->s.ptr = p->s.ptr;
 7ca:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7ce:	4790                	lw	a2,8(a5)
 7d0:	02061713          	slli	a4,a2,0x20
 7d4:	9301                	srli	a4,a4,0x20
 7d6:	0712                	slli	a4,a4,0x4
 7d8:	973e                	add	a4,a4,a5
 7da:	fae689e3          	beq	a3,a4,78c <free+0x26>
  } else
    p->s.ptr = bp;
 7de:	e394                	sd	a3,0(a5)
  freep = p;
 7e0:	00001717          	auipc	a4,0x1
 7e4:	82f73023          	sd	a5,-2016(a4) # 1000 <freep>
}
 7e8:	6422                	ld	s0,8(sp)
 7ea:	0141                	addi	sp,sp,16
 7ec:	8082                	ret

00000000000007ee <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7ee:	7139                	addi	sp,sp,-64
 7f0:	fc06                	sd	ra,56(sp)
 7f2:	f822                	sd	s0,48(sp)
 7f4:	f426                	sd	s1,40(sp)
 7f6:	f04a                	sd	s2,32(sp)
 7f8:	ec4e                	sd	s3,24(sp)
 7fa:	e852                	sd	s4,16(sp)
 7fc:	e456                	sd	s5,8(sp)
 7fe:	e05a                	sd	s6,0(sp)
 800:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 802:	02051493          	slli	s1,a0,0x20
 806:	9081                	srli	s1,s1,0x20
 808:	04bd                	addi	s1,s1,15
 80a:	8091                	srli	s1,s1,0x4
 80c:	0014899b          	addiw	s3,s1,1
 810:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 812:	00000517          	auipc	a0,0x0
 816:	7ee53503          	ld	a0,2030(a0) # 1000 <freep>
 81a:	c515                	beqz	a0,846 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 81c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 81e:	4798                	lw	a4,8(a5)
 820:	02977f63          	bgeu	a4,s1,85e <malloc+0x70>
 824:	8a4e                	mv	s4,s3
 826:	0009871b          	sext.w	a4,s3
 82a:	6685                	lui	a3,0x1
 82c:	00d77363          	bgeu	a4,a3,832 <malloc+0x44>
 830:	6a05                	lui	s4,0x1
 832:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 836:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 83a:	00000917          	auipc	s2,0x0
 83e:	7c690913          	addi	s2,s2,1990 # 1000 <freep>
  if(p == (char*)-1)
 842:	5afd                	li	s5,-1
 844:	a88d                	j	8b6 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 846:	00000797          	auipc	a5,0x0
 84a:	7ca78793          	addi	a5,a5,1994 # 1010 <base>
 84e:	00000717          	auipc	a4,0x0
 852:	7af73923          	sd	a5,1970(a4) # 1000 <freep>
 856:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 858:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 85c:	b7e1                	j	824 <malloc+0x36>
      if(p->s.size == nunits)
 85e:	02e48b63          	beq	s1,a4,894 <malloc+0xa6>
        p->s.size -= nunits;
 862:	4137073b          	subw	a4,a4,s3
 866:	c798                	sw	a4,8(a5)
        p += p->s.size;
 868:	1702                	slli	a4,a4,0x20
 86a:	9301                	srli	a4,a4,0x20
 86c:	0712                	slli	a4,a4,0x4
 86e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 870:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 874:	00000717          	auipc	a4,0x0
 878:	78a73623          	sd	a0,1932(a4) # 1000 <freep>
      return (void*)(p + 1);
 87c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 880:	70e2                	ld	ra,56(sp)
 882:	7442                	ld	s0,48(sp)
 884:	74a2                	ld	s1,40(sp)
 886:	7902                	ld	s2,32(sp)
 888:	69e2                	ld	s3,24(sp)
 88a:	6a42                	ld	s4,16(sp)
 88c:	6aa2                	ld	s5,8(sp)
 88e:	6b02                	ld	s6,0(sp)
 890:	6121                	addi	sp,sp,64
 892:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 894:	6398                	ld	a4,0(a5)
 896:	e118                	sd	a4,0(a0)
 898:	bff1                	j	874 <malloc+0x86>
  hp->s.size = nu;
 89a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 89e:	0541                	addi	a0,a0,16
 8a0:	00000097          	auipc	ra,0x0
 8a4:	ec6080e7          	jalr	-314(ra) # 766 <free>
  return freep;
 8a8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8ac:	d971                	beqz	a0,880 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ae:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8b0:	4798                	lw	a4,8(a5)
 8b2:	fa9776e3          	bgeu	a4,s1,85e <malloc+0x70>
    if(p == freep)
 8b6:	00093703          	ld	a4,0(s2)
 8ba:	853e                	mv	a0,a5
 8bc:	fef719e3          	bne	a4,a5,8ae <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 8c0:	8552                	mv	a0,s4
 8c2:	00000097          	auipc	ra,0x0
 8c6:	b5e080e7          	jalr	-1186(ra) # 420 <sbrk>
  if(p == (char*)-1)
 8ca:	fd5518e3          	bne	a0,s5,89a <malloc+0xac>
        return 0;
 8ce:	4501                	li	a0,0
 8d0:	bf45                	j	880 <malloc+0x92>
