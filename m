Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw02.it.ntnu.no ([129.241.56.175]:37578 "EHLO
        mailgw02.it.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeFAHRs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jun 2018 03:17:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailgw02.it.ntnu.no (Postfix) with ESMTP id CF56C8023B5
        for <linux-wpan@vger.kernel.org>; Fri,  1 Jun 2018 08:40:45 +0200 (CEST)
Received: from mailgw02.it.ntnu.no ([127.0.0.1])
        by localhost (mailgw02.it.ntnu.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JFwqG4Vx8btP for <linux-wpan@vger.kernel.org>;
        Fri,  1 Jun 2018 08:40:38 +0200 (CEST)
Received: from [129.241.200.162] (ginnungagap.item.ntnu.no [129.241.200.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: davidfp)
        by mailgw02.it.ntnu.no (Postfix) with ESMTPSA id A3688800788
        for <linux-wpan@vger.kernel.org>; Fri,  1 Jun 2018 08:40:38 +0200 (CEST)
Subject: Re: Kernel Soft Panic with wpan interface
References: <CAPT0++3PgW19QyZ-ShkHCLWirp9vHEQuwLKy2KxT5jm_Rw_A-w@mail.gmail.com>
From: David Palma <david.palma@ntnu.no>
Message-ID: <7cf3bd5d-3bbf-c378-020b-8a914d9448c1@ntnu.no>
Date: Fri, 1 Jun 2018 08:40:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAPT0++3PgW19QyZ-ShkHCLWirp9vHEQuwLKy2KxT5jm_Rw_A-w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="YUinN6CJCmyYUjpe9pztoraHsPSNOPgnE"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YUinN6CJCmyYUjpe9pztoraHsPSNOPgnE
Content-Type: multipart/mixed; boundary="l0SIWMjyd0RIsJNp53y57OT3JNXE415zM";
 protected-headers="v1"
From: David Palma <david.palma@ntnu.no>
To: linux-wpan@vger.kernel.org
Message-ID: <7cf3bd5d-3bbf-c378-020b-8a914d9448c1@ntnu.no>
Subject: Re: Kernel Soft Panic with wpan interface
References: <CAPT0++3PgW19QyZ-ShkHCLWirp9vHEQuwLKy2KxT5jm_Rw_A-w@mail.gmail.com>
In-Reply-To: <CAPT0++3PgW19QyZ-ShkHCLWirp9vHEQuwLKy2KxT5jm_Rw_A-w@mail.gmail.com>

--l0SIWMjyd0RIsJNp53y57OT3JNXE415zM
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable


On 31/05/18 06:50, rabi narayan sahoo wrote:
> Hi
>=20
> While using the linux-wpan(802.15.4) on linux i came across the below
> problem mentioned in the github.
>=20
> "skb_over_panic" kernel pannic when sending a simple UDP packet over a
> 6lowpan using fakelb"
>=20
> I produced the same problem in the linux kernel version 4.15 using ping=
=2E
> The callstack of soft pannic is given below
>=20
> Breakpoint 6, skb_put (skb=3D3D0xffff880006039900, len=3D3D2) at
> net/core/skbuff.c:1700
>=20
> 1700 skb_over_panic(skb, len, __builtin_return_address(0));
>=20
> (gdb) bt
>=20
> #0 skb_put (skb=3D3D0xffff880006039900, len=3D3D2) at net/core/skbuff.c=
:1700
>=20
> #1 0xffffffff81955155 in ieee802154_tx (local=3D3D0xffff8800066bac40,
> skb=3D3D0xffff880006039900) at net/mac802154/tx.c:68
>=20
> #2 0xffffffff8175f3c2 in __netdev_start_xmit (more=3D3D<optimized out>,=

> dev=3D3D<optimized out>, skb=3D3D<optimized out>, ops=3D3D<optimized ou=
t>)
>=20
> at ./include/linux/netdevice.h:4042
>=20
> #3 netdev_start_xmit (more=3D3D<optimized out>, txq=3D3D<optimized out>=
,
> dev=3D3D<optimized out>, skb=3D3D<optimized out>) at ./include/linux/ne=
tdevice.=3D
> h:
> 4051
>=20
> #4 xmit_one (more=3D3D<optimized out>, txq=3D3D<optimized out>, dev=3D3=
D<optimize=3D
> d
> out>, skb=3D3D<optimized out>) at net/core/dev.c:3003
>=20
> #5 dev_hard_start_xmit (first=3D3D0xffff880006039900, dev=3D3D0xffff880=
00667a00=3D
> 0,
> txq=3D3D<optimized out>, ret=3D3D<optimized out>) at net/core/dev.c:301=
9
>=20
> #6 0xffffffff8178c08a in sch_direct_xmit (skb=3D3D0xffff880006039900,
> q=3D3D0xffff8800060b4000, dev=3D3D0xffff88000667a000, txq=3D3D0xffff880=
006490800,
>=20
> root_lock=3D3D0xffff8800060b409c, validate=3D3D<optimized out>) at
> net/sched/sch_generic.c:187
>=20
> #7 0xffffffff8175f830 in __dev_xmit_skb (txq=3D3D<optimized out>,
> dev=3D3D<optimized out>, q=3D3D<optimized out>, skb=3D3D<optimized out>=
)
>=20
> at net/core/dev.c:3212
>=20
> #8 __dev_queue_xmit (skb=3D3D0xffff880006039900, accel_priv=3D3D<optimi=
zed out>=3D
> ) at
> net/core/dev.c:3479
>=20
> #9 0xffffffff8175fc07 in dev_queue_xmit (skb=3D3D<optimized out>) at
> net/core/dev.c:3544
>=20
> #10 0xffffffff81954823 in lowpan_xmit (skb=3D3D0xffff880006039900,
> ldev=3D3D0xffff880006346000) at net/ieee802154/6lowpan/tx.c:289
>=20
> #11 0xffffffff8175f3c2 in __netdev_start_xmit (more=3D3D<optimized out>=
,
> dev=3D3D<optimized out>, skb=3D3D<optimized out>, ops=3D3D<optimized ou=
t>)
>=20
> at ./include/linux/netdevice.h:4042
>=20
> #12 netdev_start_xmit (more=3D3D<optimized out>, txq=3D3D<optimized out=
>,
> dev=3D3D<optimized out>, skb=3D3D<optimized out>) at ./include/linux/ne=
tdevice.=3D
> h:
> 4051
>=20
> #13 xmit_one (more=3D3D<optimized out>, txq=3D3D<optimized out>, dev=3D=
3D<optimiz=3D
> ed
> out>, skb=3D3D<optimized out>) at net/core/dev.c:3003
>=20
> #14 dev_hard_start_xmit (first=3D3D0xffff880006039900, dev=3D3D0xffff88=
00063460=3D
> 00,
> txq=3D3D<optimized out>, ret=3D3D<optimized out>) at net/core/dev.c:301=
9
>=20
> #15 0xffffffff8175fb4e in __dev_queue_xmit (skb=3D3D0xffff880006039900,=

> accel_priv=3D3D<optimized out>) at net/core/dev.c:3511
>=20
> #16 0xffffffff8176c700 in neigh_update (neigh=3D3D0xffff880006066c00,
> lladdr=3D3D<optimized out>, new=3D3D<optimized out>, flags=3D3D7,
>=20
> nlmsg_pid=3D3D<optimized out>) at net/core/neighbour.c:1255
>=20
> #17 0xffffffff8184636d in ndisc_update (dev=3D3D0xffff880006346000,
> neigh=3D3D0xffff880006066c00, lladdr=3D3D<optimized out>, new=3D3D<opti=
mized out>=3D
> ,
>=20
> flags=3D3D7, icmp6_type=3D3D136 '\210', ndopts=3D3D0xffffc90000073b48) =
at
> net/ipv6/ndisc.c:743
>=20
> #18 0xffffffff81846bdd in ndisc_recv_na (skb=3D3D<optimized out>) at
> net/ipv6/ndisc.c:1026
>=20
> #19 0xffffffff81847dd1 in ndisc_rcv (skb=3D3D0xffff880006039200) at
> net/ipv6/ndisc.c:1729
>=20
> #20 0xffffffff8184ea76 in icmpv6_rcv (skb=3D3D0xffff880006039200) at
> net/ipv6/icmp.c:880
>=20
> #21 0xffffffff8182eb02 in ip6_input_finish (net=3D3D<optimized out>,
> sk=3D3D<optimized out>, skb=3D3D0xc1 <irq_stack_union+193>)
>=20
> at net/ipv6/ip6_input.c:284
>=20
> #22 0xffffffff8182ee56 in NF_HOOK (pf=3D3D<optimized out>, sk=3D3D<opti=
mized ou=3D
> t>,
> out=3D3D<optimized out>, okfn=3D3D<optimized out>, in=3D3D<optimized ou=
t>,
>=20
> skb=3D3D<optimized out>, net=3D3D<optimized out>, hook=3D3D<optimized o=
ut>) at
> ./include/linux/netfilter.h:250
>=20
> #23 ip6_input (skb=3D3D0xffff880006039900) at net/ipv6/ip6_input.c:327
>=20
> #24 0xffffffff8182f1c1 in NF_HOOK (pf=3D3D<optimized out>, sk=3D3D<opti=
mized ou=3D
> t>,
> out=3D3D<optimized out>, okfn=3D3D<optimized out>, in=3D3D<optimized ou=
t>,
>=20
> skb=3D3D<optimized out>, net=3D3D<optimized out>, hook=3D3D<optimized o=
ut>) at
> ./include/linux/netfilter.h:250
>=20
> #25 ipv6_rcv (skb=3D3D0xffff880006039200, dev=3D3D0xffff880006346000, p=
t=3D3D<opt=3D
> imized
> out>, orig_dev=3D3D<optimized out>) at net/ipv6/ip6_input.c:208
>=20
> #26 0xffffffff8175dfbc in __netif_receive_skb_core (skb=3D3D0xffff88000=
603920=3D
> 0,
> pfmemalloc=3D3D<optimized out>) at net/core/dev.c:4484
>=20
> #27 0xffffffff8175e85d in process_backlog (napi=3D3D0xffff880007c21890,=

> quota=3D3D64) at net/core/dev.c:5228
>=20
> #28 0xffffffff817609e8 in napi_poll (repoll=3D3D<optimized out>, n=3D3D=
<optimiz=3D
> ed
> out>) at net/core/dev.c:5626
>=20
> #29 net_rx_action (h=3D3D<optimized out>) at net/core/dev.c:5692
>=20
> #30 0xffffffff81c000ea in __do_softirq () at kernel/softirq.c:285
>=20
> ---Type <return> to continue, or q <return> to quit---
>=20
> #31 0xffffffff8105d9a0 in run_ksoftirqd (cpu=3D3D<optimized out>) at
> kernel/softirq.c:666
>=20
> #32 0xffffffff81076b79 in smpboot_thread_fn (data=3D3D0xffff88000603990=
0) at
> kernel/smpboot.c:164
>=20
> #33 0xffffffff81073fd0 in kthread (_create=3D3D0xffff8800070ce540) at
> kernel/kthread.c:238
>=20
> #34 0xffffffff81a00325 in ret_from_fork () at arch/x86/entry/entry_64.S=
:541
>=20
> #35 0x0000000000000000 in ?? ()
> The sate of the skbuff is shown below
> (gdb) p *skb
>=20
> $37 =3D3D {{{next =3D3D 0x0 <irq_stack_union>, prev =3D3D 0xffff8800060=
39900, {de=3D
> v =3D3D
> 0xffff88000667a000, dev_scratch =3D3D 18446612132421672960}}, rbnode =3D=
3D {
>=20
> __rb_parent_color =3D3D 0, rb_right =3D3D 0xffff880006039900, rb_left =3D=
3D
> 0xffff88000667a000}}, sk =3D3D 0xffff880006721680, {tstamp =3D3D 0,
>=20
> skb_mstamp =3D3D 0}, cb =3D3D "J", '\000' <repeats 46 times>, {{_skb_re=
fdst =3D3D=3D
>  0,
> destructor =3D3D 0xffffffff817469c0 <sock_wfree>},
>=20
> tcp_tsorted_anchor =3D3D {next =3D3D 0x0 <irq_stack_union>, prev =3D3D
> 0xffffffff817469c0 <sock_wfree>}}, sp =3D3D 0x0 <irq_stack_union>, _nfc=
t =3D3D =3D
> 0,
>=20
> len =3D3D 76, data_len =3D3D 0, mac_len =3D3D 21, hdr_len =3D3D 0, queu=
e_mapping =3D
> =3D3D 0,
> __cloned_offset =3D3D 0xffff880006039986 "\001", cloned =3D3D 1 '\001',=

>=20
> nohdr =3D3D 0 '\000', fclone =3D3D 0 '\000', peeked =3D3D 0 '\000', hea=
d_frag =3D3D=3D
>  0
> '\000', xmit_more =3D3D 0 '\000', __unused =3D3D 0 '\000',
>=20
> headers_start =3D3D 0xffff880006039988, __pkt_type_offset =3D3D 0xffff8=
80006039=3D
> 988
> "\020\006", pkt_type =3D3D 0 '\000', pfmemalloc =3D3D 0 '\000',
>=20
> ignore_df =3D3D 1 '\001', nf_trace =3D3D 0 '\000', ip_summed =3D3D 0 '\=
000', ooo_=3D
> okay =3D3D
> 0 '\000', l4_hash =3D3D 1 '\001', sw_hash =3D3D 1 '\001',
>=20
> wifi_acked_valid =3D3D 0 '\000', wifi_acked =3D3D 0 '\000', no_fcs =3D3=
D 0 '\000'=3D
> ,
> encapsulation =3D3D 0 '\000', encap_hdr_csum =3D3D 0 '\000',
>=20
> csum_valid =3D3D 0 '\000', csum_complete_sw =3D3D 0 '\000', csum_level =
=3D3D 0 '\=3D
> 000',
> csum_not_inet =3D3D 0 '\000', dst_pending_confirm =3D3D 0 '\000',
>=20
> ndisc_nodetype =3D3D 0 '\000', ipvs_property =3D3D 0 '\000', inner_prot=
ocol_typ=3D
> e =3D3D
> 0 '\000', remcsum_offload =3D3D 0 '\000',
>=20
> tc_skip_classify =3D3D 0 '\000', tc_at_ingress =3D3D 0 '\000', tc_redir=
ected =3D
> =3D3D 0
> '\000', tc_from_ingress =3D3D 0 '\000', tc_index =3D3D 0, {
>=20
> csum =3D3D 3212388667, {csum_start =3D3D 10555, csum_offset =3D3D 49017=
}}, priori=3D
> ty =3D3D
> 0, skb_iif =3D3D 3, hash =3D3D 332563606, vlan_proto =3D3D 0, vlan_tci =
=3D3D 0, {
>=20
> napi_id =3D3D 1, sender_cpu =3D3D 1}, secmark =3D3D 0, {mark =3D3D 0, r=
eserved_tail=3D
> room =3D3D
> 0}, {inner_protocol =3D3D 0, inner_ipproto =3D3D 0 '\000'},
>=20
> inner_transport_header =3D3D 0, inner_network_header =3D3D 0, inner_mac=
_header =3D
> =3D3D 0,
> protocol =3D3D 56710, transport_header =3D3D 144, network_header =3D3D =
138,
>=20
> mac_header =3D3D 117, headers_end =3D3D 0xffff8800060399c0, tail =3D3D =
193, end =3D
> =3D3D 192,
> head =3D3D 0xffff88000621d600 "",
>=20
> data =3D3D 0xffff88000621d675 "A\314t=3DCD=3DAB\241\345}\341I=3DD4=3DBE=
\336U\
> 024\263\234\005v(\256j3\004\322\023:\200", truesize =3D3D 768, users =3D=
3D {ref=3D
> s =3D3D {
>=20
> counter =3D3D 1}}}
>=20
> You Can See tail offset is 193 and end offset is 192. Its the problem.
>=20
> In 802.15.4 MAC =3DE2=3D80=3D9CIn order to detect bit errors, an Frame =
Check Sequ=3D
> ence
> (FCS) mechanism,employing a 16 bit Cyclic Redundancy Check (CRC) is use=
d to
> protect every frame.=3DE2=3D80=3D9D This two byte is added at the end o=
f the MAC =3D
> frame.
>=20
> In Linux when one skbuff is created for an out going packet all the MAC=
 and
> Hardware header space id reserved at head region of the skbuff.
>=20
> To debug the issue , i created two lbs (wpan0 and wpan1), and added a
> lowpan link (lowpan0 and lowpan1) using fakelb. I start pinging lowpan1=

> from lowpan0 using the link local Ipv6 address. Ping packet payload len=
gth
> was 39 bytes.
>=20
>=20
> When i send the echo request __ip6_append_data function in kernel will
> create the sk_buff to be sent over the lwpan network. In this function =
it
> will calculate the entrire packet size (any hardware header+MAC header+=
IPv6
> header+IPv6 extended header+Next header+user payload+IPsec header etc)
>=20
> static int __ip6_append_data(struct sock *sk,
> struct flowi6 *fl6,
>=20
> struct sk_buff_head *queue,
>=20
> struct inet_cork *cork,
>=20
> struct inet6_cork *v6_cork,
>=20
> struct page_frag *pfrag,
>=20
> int getfrag(void *from, char *to, int offset,
>=20
> int len, int odd, struct sk_buff *skb),
>=20
> void *from, int length, int transhdrlen,
>=20
> unsigned int flags, struct ipcm6_cookie *ipc6,
>=20
> const struct sockcm_cookie *sockc)
>=20
> {
> ...................................
>=20
> hh_len =3D3D LL_RESERVED_SPACE(rt->dst.dev);  ---> hardware header leng=
h For =3D
> my
> packet this value was 96 .
> .................................
>=20
> skb =3D3D NULL;
>=20
> if (refcount_read(&sk->sk_wmem_alloc) <=3D3D
>=20
> 2 * sk->sk_sndbuf)
>=20
> skb =3D3D sock_wmalloc(sk,
>=20
> alloclen + hh_len, 1,
>=20
> sk->sk_allocation);
>=20
>=20
> /* Size of SKB to be allocated was 191 96 bytes hh_len and 95 bytes of
> alloclen*/
>=20
> /* reserve for fragmentation and ipsec header */
>=20
> skb_reserve(skb, hh_len + sizeof(struct frag_hdr) +
>=20
> dst_exthdrlen);
>=20
> /* Only the initial fragment is time stamped */
>=20
> skb_shinfo(skb)->tx_flags =3D3D tx_flags;
>=20
> tx_flags =3D3D 0;
>=20
> skb_shinfo(skb)->tskey =3D3D tskey;
>=20
> tskey =3D3D 0;
>=20
>=20
> /*
>=20
> * Find where to start putting bytes
>=20
> */
>=20
> data =3D3D skb_put(skb, fraglen);
>=20
> skb_set_network_header(skb, exthdrlen);
>=20
> After skb_reserve (for 104 bytes) and skb_put (87 bytes ) gets executed=

> value of skb tail will be 191 and end will be 192.
>=20
> The same skb will be passed to 6lowpan_xmit to do 6lowpan compression a=
nd
> add ieee802154 mac header. These headers will added between and skb->he=
ad
> and skb->data.
>=20
> After MAC frame is added above skb will passed to the ieee802154_tx. In=

> this function it will try to add 2 bytes of CRC at the end of the packe=
t.
> So to add it to end it will call skb_put by 2 bytes to move tail by 2 b=
ytes
> for making space. So it will go beyond end value (192) .
>=20
>=20
> So what i feel its not only this range of ping bytes has the problem. W=
hen
> the number of bytes between end and tail is less than 2 bytes this prob=
lem
> will occur.
>=20
> Can any one suggest how to fix this problem?
>=20
> I can think of 2 solutions
>=20
> 1-- While making the skbuff over 802.15.4 in __ip6_append_data we MUST
> reserve two bytes at the end for CRC.
>=20
> 2-- Even after adding the MAC header and 6lowpan header we have space
> available on top of the skb (between data and head mac_header =3D3D 117=
). So =3D
> in
> ieee802154_tx kernel can check if 2 bytes is not available at end of th=
e
> packet it can move the packet up to make space at the end.
>=20
> Thanks
> Rabi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


Hi,

Maybe this is connected to:

- https://bugzilla.kernel.org/show_bug.cgi?id=3D195059 ?
-
http://lists-archives.com/linux-kernel/28794462-skb_over_panic-using-udp-=
and-6lowpan-fakelb.html

Cheers,
--
David


--l0SIWMjyd0RIsJNp53y57OT3JNXE415zM--

--YUinN6CJCmyYUjpe9pztoraHsPSNOPgnE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEl+q6ZBx359wpOo2MJseEIZzXsVoFAlsQ6mIACgkQJseEIZzX
sVpcog/9Gm37MU1UgbNOxrAviWGF/FkHS1lwAw9MCwoWROEZFEYPrz6zkTvNmYP6
fQtlqn2LRmEn1SFzGEXD0QJWqAyg9gY0+uAcZgCoHkhDnAVJJfoR+msMhhb6qyId
03ivTn8inWiywlTJFCFlAuzayXpFZH3GUuCZ7RFQ6gi3+VfYSlNKqOD/Ensq1dO5
lj8P0I3aKfsYqp9ZDW4qSo9II10BsYhXIWLmaRtZEVs0DMwBage3WAx/Na1p5ZR2
IgyxhHriRp+ES6Sa0wqoL+1cbdoYwOpaVQMltNmMFkQ9XRdmecil116Z+SyALGkc
zYPzdpVU8xFlJCckX32e1Bao4vuf0BuLrbG67FdtTfgzMOv7Sfn46edzyFTHtLPg
NLHJNCy6Q5gfRfkbe5rqpRMG2JY7FTSadSTMKrxTgovll0853p7FtiivIAHXmH0r
+y/O8m7kF2UDSddoPoDsZhwiNAQt2IPJwVUuT0uw3TP5AvQ18OJ3FAybgIn0bXxM
2lPTBhIQ37Eg23Dpc63vKnTS2uHObUpxb6dvfm/FT0s2IjXDk3WF94fq3teAUpDB
Q7n2zroC80KpwiUNt8TpVYfZRkEFzTE6QEUIu9XN1ZO8vVKAReR+M9Nn2/rfsp2X
urcRJKg7L1PxZpVvci7ehcE6hoWcwtspFPLN7XU16Gtdnc010L8=
=t2Gb
-----END PGP SIGNATURE-----

--YUinN6CJCmyYUjpe9pztoraHsPSNOPgnE--
