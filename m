Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:39867 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeEaEuk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 31 May 2018 00:50:40 -0400
Received: by mail-it0-f68.google.com with SMTP id c3-v6so26456504itj.4
        for <linux-wpan@vger.kernel.org>; Wed, 30 May 2018 21:50:39 -0700 (PDT)
MIME-Version: 1.0
From: rabi narayan sahoo <rabinarayans0828@gmail.com>
Date: Thu, 31 May 2018 10:20:38 +0530
Message-ID: <CAPT0++3PgW19QyZ-ShkHCLWirp9vHEQuwLKy2KxT5jm_Rw_A-w@mail.gmail.com>
Subject: Kernel Soft Panic with wpan interface
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi

While using the linux-wpan(802.15.4) on linux i came across the below
problem mentioned in the github.

"skb_over_panic" kernel pannic when sending a simple UDP packet over a
6lowpan using fakelb"

I produced the same problem in the linux kernel version 4.15 using ping.
The callstack of soft pannic is given below

Breakpoint 6, skb_put (skb=3D0xffff880006039900, len=3D2) at
net/core/skbuff.c:1700

1700 skb_over_panic(skb, len, __builtin_return_address(0));

(gdb) bt

#0 skb_put (skb=3D0xffff880006039900, len=3D2) at net/core/skbuff.c:1700

#1 0xffffffff81955155 in ieee802154_tx (local=3D0xffff8800066bac40,
skb=3D0xffff880006039900) at net/mac802154/tx.c:68

#2 0xffffffff8175f3c2 in __netdev_start_xmit (more=3D<optimized out>,
dev=3D<optimized out>, skb=3D<optimized out>, ops=3D<optimized out>)

at ./include/linux/netdevice.h:4042

#3 netdev_start_xmit (more=3D<optimized out>, txq=3D<optimized out>,
dev=3D<optimized out>, skb=3D<optimized out>) at ./include/linux/netdevice.=
h:
4051

#4 xmit_one (more=3D<optimized out>, txq=3D<optimized out>, dev=3D<optimize=
d
out>, skb=3D<optimized out>) at net/core/dev.c:3003

#5 dev_hard_start_xmit (first=3D0xffff880006039900, dev=3D0xffff88000667a00=
0,
txq=3D<optimized out>, ret=3D<optimized out>) at net/core/dev.c:3019

#6 0xffffffff8178c08a in sch_direct_xmit (skb=3D0xffff880006039900,
q=3D0xffff8800060b4000, dev=3D0xffff88000667a000, txq=3D0xffff880006490800,

root_lock=3D0xffff8800060b409c, validate=3D<optimized out>) at
net/sched/sch_generic.c:187

#7 0xffffffff8175f830 in __dev_xmit_skb (txq=3D<optimized out>,
dev=3D<optimized out>, q=3D<optimized out>, skb=3D<optimized out>)

at net/core/dev.c:3212

#8 __dev_queue_xmit (skb=3D0xffff880006039900, accel_priv=3D<optimized out>=
) at
net/core/dev.c:3479

#9 0xffffffff8175fc07 in dev_queue_xmit (skb=3D<optimized out>) at
net/core/dev.c:3544

#10 0xffffffff81954823 in lowpan_xmit (skb=3D0xffff880006039900,
ldev=3D0xffff880006346000) at net/ieee802154/6lowpan/tx.c:289

#11 0xffffffff8175f3c2 in __netdev_start_xmit (more=3D<optimized out>,
dev=3D<optimized out>, skb=3D<optimized out>, ops=3D<optimized out>)

at ./include/linux/netdevice.h:4042

#12 netdev_start_xmit (more=3D<optimized out>, txq=3D<optimized out>,
dev=3D<optimized out>, skb=3D<optimized out>) at ./include/linux/netdevice.=
h:
4051

#13 xmit_one (more=3D<optimized out>, txq=3D<optimized out>, dev=3D<optimiz=
ed
out>, skb=3D<optimized out>) at net/core/dev.c:3003

#14 dev_hard_start_xmit (first=3D0xffff880006039900, dev=3D0xffff8800063460=
00,
txq=3D<optimized out>, ret=3D<optimized out>) at net/core/dev.c:3019

#15 0xffffffff8175fb4e in __dev_queue_xmit (skb=3D0xffff880006039900,
accel_priv=3D<optimized out>) at net/core/dev.c:3511

#16 0xffffffff8176c700 in neigh_update (neigh=3D0xffff880006066c00,
lladdr=3D<optimized out>, new=3D<optimized out>, flags=3D7,

nlmsg_pid=3D<optimized out>) at net/core/neighbour.c:1255

#17 0xffffffff8184636d in ndisc_update (dev=3D0xffff880006346000,
neigh=3D0xffff880006066c00, lladdr=3D<optimized out>, new=3D<optimized out>=
,

flags=3D7, icmp6_type=3D136 '\210', ndopts=3D0xffffc90000073b48) at
net/ipv6/ndisc.c:743

#18 0xffffffff81846bdd in ndisc_recv_na (skb=3D<optimized out>) at
net/ipv6/ndisc.c:1026

#19 0xffffffff81847dd1 in ndisc_rcv (skb=3D0xffff880006039200) at
net/ipv6/ndisc.c:1729

#20 0xffffffff8184ea76 in icmpv6_rcv (skb=3D0xffff880006039200) at
net/ipv6/icmp.c:880

#21 0xffffffff8182eb02 in ip6_input_finish (net=3D<optimized out>,
sk=3D<optimized out>, skb=3D0xc1 <irq_stack_union+193>)

at net/ipv6/ip6_input.c:284

#22 0xffffffff8182ee56 in NF_HOOK (pf=3D<optimized out>, sk=3D<optimized ou=
t>,
out=3D<optimized out>, okfn=3D<optimized out>, in=3D<optimized out>,

skb=3D<optimized out>, net=3D<optimized out>, hook=3D<optimized out>) at
./include/linux/netfilter.h:250

#23 ip6_input (skb=3D0xffff880006039900) at net/ipv6/ip6_input.c:327

#24 0xffffffff8182f1c1 in NF_HOOK (pf=3D<optimized out>, sk=3D<optimized ou=
t>,
out=3D<optimized out>, okfn=3D<optimized out>, in=3D<optimized out>,

skb=3D<optimized out>, net=3D<optimized out>, hook=3D<optimized out>) at
./include/linux/netfilter.h:250

#25 ipv6_rcv (skb=3D0xffff880006039200, dev=3D0xffff880006346000, pt=3D<opt=
imized
out>, orig_dev=3D<optimized out>) at net/ipv6/ip6_input.c:208

#26 0xffffffff8175dfbc in __netif_receive_skb_core (skb=3D0xffff88000603920=
0,
pfmemalloc=3D<optimized out>) at net/core/dev.c:4484

#27 0xffffffff8175e85d in process_backlog (napi=3D0xffff880007c21890,
quota=3D64) at net/core/dev.c:5228

#28 0xffffffff817609e8 in napi_poll (repoll=3D<optimized out>, n=3D<optimiz=
ed
out>) at net/core/dev.c:5626

#29 net_rx_action (h=3D<optimized out>) at net/core/dev.c:5692

#30 0xffffffff81c000ea in __do_softirq () at kernel/softirq.c:285

---Type <return> to continue, or q <return> to quit---

#31 0xffffffff8105d9a0 in run_ksoftirqd (cpu=3D<optimized out>) at
kernel/softirq.c:666

#32 0xffffffff81076b79 in smpboot_thread_fn (data=3D0xffff880006039900) at
kernel/smpboot.c:164

#33 0xffffffff81073fd0 in kthread (_create=3D0xffff8800070ce540) at
kernel/kthread.c:238

#34 0xffffffff81a00325 in ret_from_fork () at arch/x86/entry/entry_64.S:541

#35 0x0000000000000000 in ?? ()
The sate of the skbuff is shown below
(gdb) p *skb

$37 =3D {{{next =3D 0x0 <irq_stack_union>, prev =3D 0xffff880006039900, {de=
v =3D
0xffff88000667a000, dev_scratch =3D 18446612132421672960}}, rbnode =3D {

__rb_parent_color =3D 0, rb_right =3D 0xffff880006039900, rb_left =3D
0xffff88000667a000}}, sk =3D 0xffff880006721680, {tstamp =3D 0,

skb_mstamp =3D 0}, cb =3D "J", '\000' <repeats 46 times>, {{_skb_refdst =3D=
 0,
destructor =3D 0xffffffff817469c0 <sock_wfree>},

tcp_tsorted_anchor =3D {next =3D 0x0 <irq_stack_union>, prev =3D
0xffffffff817469c0 <sock_wfree>}}, sp =3D 0x0 <irq_stack_union>, _nfct =3D =
0,

len =3D 76, data_len =3D 0, mac_len =3D 21, hdr_len =3D 0, queue_mapping =
=3D 0,
__cloned_offset =3D 0xffff880006039986 "\001", cloned =3D 1 '\001',

nohdr =3D 0 '\000', fclone =3D 0 '\000', peeked =3D 0 '\000', head_frag =3D=
 0
'\000', xmit_more =3D 0 '\000', __unused =3D 0 '\000',

headers_start =3D 0xffff880006039988, __pkt_type_offset =3D 0xffff880006039=
988
"\020\006", pkt_type =3D 0 '\000', pfmemalloc =3D 0 '\000',

ignore_df =3D 1 '\001', nf_trace =3D 0 '\000', ip_summed =3D 0 '\000', ooo_=
okay =3D
0 '\000', l4_hash =3D 1 '\001', sw_hash =3D 1 '\001',

wifi_acked_valid =3D 0 '\000', wifi_acked =3D 0 '\000', no_fcs =3D 0 '\000'=
,
encapsulation =3D 0 '\000', encap_hdr_csum =3D 0 '\000',

csum_valid =3D 0 '\000', csum_complete_sw =3D 0 '\000', csum_level =3D 0 '\=
000',
csum_not_inet =3D 0 '\000', dst_pending_confirm =3D 0 '\000',

ndisc_nodetype =3D 0 '\000', ipvs_property =3D 0 '\000', inner_protocol_typ=
e =3D
0 '\000', remcsum_offload =3D 0 '\000',

tc_skip_classify =3D 0 '\000', tc_at_ingress =3D 0 '\000', tc_redirected =
=3D 0
'\000', tc_from_ingress =3D 0 '\000', tc_index =3D 0, {

csum =3D 3212388667, {csum_start =3D 10555, csum_offset =3D 49017}}, priori=
ty =3D
0, skb_iif =3D 3, hash =3D 332563606, vlan_proto =3D 0, vlan_tci =3D 0, {

napi_id =3D 1, sender_cpu =3D 1}, secmark =3D 0, {mark =3D 0, reserved_tail=
room =3D
0}, {inner_protocol =3D 0, inner_ipproto =3D 0 '\000'},

inner_transport_header =3D 0, inner_network_header =3D 0, inner_mac_header =
=3D 0,
protocol =3D 56710, transport_header =3D 144, network_header =3D 138,

mac_header =3D 117, headers_end =3D 0xffff8800060399c0, tail =3D 193, end =
=3D 192,
head =3D 0xffff88000621d600 "",

data =3D 0xffff88000621d675 "A\314t=CD=AB\241\345}\341I=D4=BE\336U\
024\263\234\005v(\256j3\004\322\023:\200", truesize =3D 768, users =3D {ref=
s =3D {

counter =3D 1}}}

You Can See tail offset is 193 and end offset is 192. Its the problem.

In 802.15.4 MAC =E2=80=9CIn order to detect bit errors, an Frame Check Sequ=
ence
(FCS) mechanism,employing a 16 bit Cyclic Redundancy Check (CRC) is used to
protect every frame.=E2=80=9D This two byte is added at the end of the MAC =
frame.

In Linux when one skbuff is created for an out going packet all the MAC and
Hardware header space id reserved at head region of the skbuff.

To debug the issue , i created two lbs (wpan0 and wpan1), and added a
lowpan link (lowpan0 and lowpan1) using fakelb. I start pinging lowpan1
from lowpan0 using the link local Ipv6 address. Ping packet payload length
was 39 bytes.


When i send the echo request __ip6_append_data function in kernel will
create the sk_buff to be sent over the lwpan network. In this function it
will calculate the entrire packet size (any hardware header+MAC header+IPv6
header+IPv6 extended header+Next header+user payload+IPsec header etc)

static int __ip6_append_data(struct sock *sk,
struct flowi6 *fl6,

struct sk_buff_head *queue,

struct inet_cork *cork,

struct inet6_cork *v6_cork,

struct page_frag *pfrag,

int getfrag(void *from, char *to, int offset,

int len, int odd, struct sk_buff *skb),

void *from, int length, int transhdrlen,

unsigned int flags, struct ipcm6_cookie *ipc6,

const struct sockcm_cookie *sockc)

{
...................................

hh_len =3D LL_RESERVED_SPACE(rt->dst.dev);  ---> hardware header lengh For =
my
packet this value was 96 .
.................................

skb =3D NULL;

if (refcount_read(&sk->sk_wmem_alloc) <=3D

2 * sk->sk_sndbuf)

skb =3D sock_wmalloc(sk,

alloclen + hh_len, 1,

sk->sk_allocation);


/* Size of SKB to be allocated was 191 96 bytes hh_len and 95 bytes of
alloclen*/

/* reserve for fragmentation and ipsec header */

skb_reserve(skb, hh_len + sizeof(struct frag_hdr) +

dst_exthdrlen);

/* Only the initial fragment is time stamped */

skb_shinfo(skb)->tx_flags =3D tx_flags;

tx_flags =3D 0;

skb_shinfo(skb)->tskey =3D tskey;

tskey =3D 0;


/*

* Find where to start putting bytes

*/

data =3D skb_put(skb, fraglen);

skb_set_network_header(skb, exthdrlen);

After skb_reserve (for 104 bytes) and skb_put (87 bytes ) gets executed
value of skb tail will be 191 and end will be 192.

The same skb will be passed to 6lowpan_xmit to do 6lowpan compression and
add ieee802154 mac header. These headers will added between and skb->head
and skb->data.

After MAC frame is added above skb will passed to the ieee802154_tx. In
this function it will try to add 2 bytes of CRC at the end of the packet.
So to add it to end it will call skb_put by 2 bytes to move tail by 2 bytes
for making space. So it will go beyond end value (192) .


So what i feel its not only this range of ping bytes has the problem. When
the number of bytes between end and tail is less than 2 bytes this problem
will occur.

Can any one suggest how to fix this problem?

I can think of 2 solutions

1-- While making the skbuff over 802.15.4 in __ip6_append_data we MUST
reserve two bytes at the end for CRC.

2-- Even after adding the MAC header and 6lowpan header we have space
available on top of the skb (between data and head mac_header =3D 117). So =
in
ieee802154_tx kernel can check if 2 bytes is not available at end of the
packet it can move the packet up to make space at the end.

Thanks
Rabi
