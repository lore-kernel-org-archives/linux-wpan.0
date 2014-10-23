Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:61158 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbaJWJvk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Oct 2014 05:51:40 -0400
Message-ID: <5448CFA8.3020604@xsilon.com>
Date: Thu, 23 Oct 2014 10:51:36 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bluetooth-next 0/4] 6lowpan: Move skb delivery out
 of IPHC
References: <1413967190-28890-1-git-send-email-martin.townsend@xsilon.com> <20141023094355.GA11768@x61s.guest.pengutronix.de>
In-Reply-To: <20141023094355.GA11768@x61s.guest.pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

Hi Alex,

Looks like the SKB is now non-linear which causes the skb_put to assert.  Maybe skb_linearlize will help[0]

I'll also take a look.

- Martin.

[0] http://lxr.free-electrons.com/source/include/linux/skbuff.h#L2399


On 23/10/14 10:43, Alexander Aring wrote:
> Hi Martin,
>
> On Wed, Oct 22, 2014 at 09:39:46AM +0100, Martin Townsend wrote:
>> This series moves skb delivery out of IPHC and into the receive routines of
>> both bluetooth and 802.15.4.  The reason is that we need to support more
>> (de)compression schemes in the future.  It also means that calling 
>> lowpan_process_data now only returns error codes or 0 for success so 
>> this has been cleaned up.  The final patch then renames occurences of
>> lowpan_process_data and process_data to something more meaningful.
>>
> With this series and running fragmented 6LoWPAN packet on 802.15.4 a BUG()
> occurs.
>
> I can't bisect this issue and take a deeper look into this now. I have at
> weekend more time for this. Can you try a simple fragmented ping like "ping6
> $IP -s 127"? Do you get a similar issue?
>
> [   73.250963] ------------[ cut here ]------------
> [   73.255840] kernel BUG at net/core/skbuff.c:1275!
> [   73.260770] Internal error: Oops - BUG: 0 [#1] ARM
> [   73.265791] Modules linked in: autofs4
> [   73.269753] CPU: 0 PID: 39 Comm: kworker/u2:1 Tainted: G        W      3.17.0-rc1-118898-g89f5047 #5
> [   73.279347] Workqueue: wpan-phy0 mac802154_rx_worker
> [   73.284557] task: cf20e2c0 ti: cf2d8000 task.ti: cf2d8000
> [   73.290223] PC is at skb_put+0x18/0x50
> [   73.294153] LR is at 0x7fffff00
> [   73.297448] pc : [<c041000c>]    lr : [<7fffff00>]    psr: 20000013
> [   73.297448] sp : cf2d9c48  ip : cf50e71a  fp : cf5aba00
> [   73.309467] r10: cf2d9c84  r9 : cf2d9c83  r8 : cf4ab000
> [   73.314939] r7 : 80000000  r6 : cf5aba00  r5 : cf5aba00  r4 : cf5aba00
> [   73.321774] r3 : 00000000  r2 : c0410700  r1 : 80000000  r0 : cf5aba00
> [   73.328612] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [   73.336267] Control: 10c5387d  Table: 8f408019  DAC: 00000015
> [   73.342283] Process kworker/u2:1 (pid: 39, stack limit = 0xcf2d8240)
> [   73.348937] Stack: (0xcf2d9c48 to 0xcf2da000)
> [   73.353510] 9c40:                   00000000 cf5aba00 cf5aba00 c0410700 cf2d9c84 cf5aba00
> [   73.362081] 9c60: cf596bd0 cf5aba00 00000000 cf4ab000 cf5aba00 c0000dc0 cf5aba00 c058bc78
> [   73.370651] 9c80: 0020e2c0 00000000 cf2d9c90 cf2d9ca0 abcdf303 000000f3 aaaaaaaa aaaaaaaa
> [   73.379222] 9ca0: abcd0003 00000000 aaaaaabb aaaaaaaa cf5aba00 cf5aba00 cf4ab000 cf5aba00
> [   73.387792] 9cc0: 00000000 0000f600 cf4ab000 c0821ba8 00000000 c058b208 00000000 c005eb18
> [   73.396363] 9ce0: c08645fc 60000013 00000000 cf2d8000 c0f8cc61 00000002 abcd0003 00000000
> [   73.404932] 9d00: aaaaaaaa aaaaaaaa abcd0003 00000000 aaaaaabb aaaaaaaa 00000000 00000000
> [   73.413503] 9d20: c0865c40 cf5abb80 c0821b68 c08646e0 c08644fc cf5abb80 00000000 c041ac5c
> [   73.422074] 9d40: 00000000 00000000 c041a86c 00000002 00000003 00000040 c0865c40 cf5abb80
> [   73.430644] 9d60: cf20e2c0 c0864510 00000001 c0865c40 cf5abb80 00000000 c0865c14 c0865bd4
> [   73.439215] 9d80: 00000040 c0865c40 c0865bc8 c041c1dc cf20e2c0 c0865bc0 0000012c 00000040
> [   73.447787] 9da0: c0865bc0 c0865bc8 ffffa76e c041bb20 c086714c ffffa76e c041ba6c 00000008
> [   73.456357] 9dc0: cf2d8020 cf2d8000 c0867140 00000100 c0867100 c086714c 00000004 c00366b0
> [   73.464927] 9de0: cf20e2c0 cf2d8038 00000003 40000003 0000000a 04208060 00000000 ffffa76d
> [   73.473497] 9e00: 20000013 60000013 aaaaaaaa cf5abb80 cf4ab520 cf4ab538 cf2d8030 00000001
> [   73.482067] 9e20: 00000000 c00368a0 00000000 c041b518 00000000 c058e14c 00000000 00000000
> [   73.490638] 9e40: c058df74 c005eb18 cf320a9c cf4ab520 cff8cc61 cf320a9c abcdf303 000000f3
> [   73.499208] 9e60: aaaaaaaa aaaaaaaa abcd0003 00000000 aaaaaabb aaaaaaaa 00000001 cf320a9c
> [   73.507780] 9e80: 00000000 cf5abb80 cf5abb80 cf320a60 cd9e1200 cf2d9ec8 cf03ea00 c058c7ec
> [   73.516351] 9ea0: cf2d4d40 cd9e1204 cf036400 c0045fc4 00000001 00000000 c0045f4c 60000093
> [   73.524921] 9ec0: 00000000 00000000 c1082b28 c0bb9980 00000000 c0765727 cf20e2c0 cf2d4d40
> [   73.533492] 9ee0: cf036400 cf036400 c0832920 cf036430 cf2d8000 cf2d4d58 00000000 c0046b64
> [   73.542063] 9f00: cf2d4d40 cf20e2c0 00000000 cf2d2400 00000000 cf2d4d40 c004688c 00000000
> [   73.550633] 9f20: 00000000 00000000 00000000 c004a0a0 c0831550 00000000 cf20e2c0 cf2d4d40
> [   73.559202] 9f40: 00000000 00000001 dead4ead ffffffff ffffffff c086769c 00000000 00000000
> [   73.567772] 9f60: c07038f4 cf2d9f64 cf2d9f64 00000000 00000001 dead4ead ffffffff ffffffff
> [   73.576342] 9f80: c086769c 00000000 00000000 c07038f4 cf2d9f90 cf2d9f90 cf2d9fac cf2d2400
> [   73.584910] 9fa0: c0049fcc 00000000 00000000 c000db88 00000000 00000000 00000000 00000000
> [   73.593479] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   73.602048] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 fefffbae bf3baaae
> [   73.610626] [<c041000c>] (skb_put) from [<c0410700>] (skb_try_coalesce+0x6c/0x32c)
> [   73.618564] [<c0410700>] (skb_try_coalesce) from [<c058bc78>] (lowpan_frag_rcv+0x668/0x7a8)
> [   73.627318] [<c058bc78>] (lowpan_frag_rcv) from [<c058b208>] (lowpan_rcv+0xc8/0x1f0)
> [   73.635441] [<c058b208>] (lowpan_rcv) from [<c041ac5c>] (__netif_receive_skb_core+0x43c/0x56c)
> [   73.644470] [<c041ac5c>] (__netif_receive_skb_core) from [<c041c1dc>] (process_backlog+0x78/0x110)
> [   73.653860] [<c041c1dc>] (process_backlog) from [<c041bb20>] (net_rx_action+0xb4/0x18c)
> [   73.662267] [<c041bb20>] (net_rx_action) from [<c00366b0>] (__do_softirq+0x104/0x264)
> [   73.670478] [<c00366b0>] (__do_softirq) from [<c00368a0>] (do_softirq+0x44/0x6c)
> [   73.678233] [<c00368a0>] (do_softirq) from [<c041b518>] (netif_rx_ni+0x20/0x2c)
> [   73.685900] [<c041b518>] (netif_rx_ni) from [<c058e14c>] (mac802154_wpans_rx+0x208/0x260)
> [   73.694472] [<c058e14c>] (mac802154_wpans_rx) from [<c058c7ec>] (mac802154_rx_worker+0x7c/0x94)
> [   73.703594] [<c058c7ec>] (mac802154_rx_worker) from [<c0045fc4>] (process_one_work+0x23c/0x3cc)
> [   73.712712] [<c0045fc4>] (process_one_work) from [<c0046b64>] (worker_thread+0x2d8/0x438)
>
> - Alex

