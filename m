Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:62857 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbbEGP1W (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 May 2015 11:27:22 -0400
Message-ID: <554B8456.9090107@xsilon.com>
Date: Thu, 07 May 2015 16:27:18 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: Oops with latest bluetooth-next kernel.
References: <554B414B.50408@xsilon.com> <20150507122441.GA17485@omega>
In-Reply-To: <20150507122441.GA17485@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Thanks for your reply Alex,  after a bit of debugging I've tracked it down to our RPL application.  If I disable this at startup there are no lock ups.  As soon as I start the daemon it brings the Kernel down so I need to investigate why this happens.

I'll have a go at updating the fakelb as it's useful for RPL and MPL.

- Martin


On 07/05/15 13:24, Alexander Aring wrote:
> Hi Martin,
>
> welcome back.
>
> On Thu, May 07, 2015 at 11:41:15AM +0100, Martin Townsend wrote:
>> Hi,
>>
>> I've recently upgraded my kernel to bluetooth-net-next with the latest lrwpan-tools and find that I get the following Oops:
>>
>> We have 3 wpan interfaces, a powerline, a wireless, and a fakelb interface.  If I disable the wireless interface everything is fine.  If I disable the fakelb interface all is well.  The problem seems to be when all 3 interfaces are up.   This used to work in our 3.16 Kernel.
>> Aslo we never saw the IPv6: fakelowpan: IPv6 duplicate address fe80::203:9a00:2:12c detected! message in the old build.
>>
>> Starting 802.15.4 loopback:
> Again, I would not trust the fakelb driver. Because I see some things
> which goes wrong in this driver. See below.
>
>> [   25.215772] ieee802154fakelb ieee802154fakelb: added ieee802154 hardware
>> iwpan phy phy2 interface add wpan2 type node 00:03:9a:00:00:02:01:2c
>> ip link add link wpan2 name fakelowpan type lowpan
>> ifconfig fakelowpan up
>> ifconfig wpan2 up
>> [   26.839092] IPv6: fakelowpan: IPv6 duplicate address fe80::203:9a00:2:12c detected!
> This occurs because the fakelb driver transmit a frame and also receive
> the same frame, this should not happen. I think this is an easy fix, but
> no time and too lazy such things to fix that. Also the fakelb driver
> should be easily to change it to xmit_async behaviour.
>
> Meanwhile I think to told everytime that I declare the fakelb driver as
> broken costs more time to implement a new one. :-)
>
>> [   27.109497] Unable to handle kernel NULL pointer dereference at virtual address 00000004
>> [   27.117623] pgd = c0004000
>> [   27.120369] [00000004] *pgd=00000000
>> [   27.123937] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
>> [   27.129300] Modules linked in: fakelb mrf24j40 adc7923(O) hanadu(O) ansi_cprng
>> [   27.136547] CPU: 0 PID: 19 Comm: kworker/u4:1 Tainted: G           O    4.0.0-rc7-brian #2
>> [   27.144783] Hardware name: Xilinx Zynq Platform
>> [   27.149337] task: df49c500 ti: df4c0000 task.ti: df4c0000
>> [   27.154766] PC is at process_one_work+0x24/0x330
>> [   27.159373] LR is at worker_thread+0x4c/0x474
>> [   27.163722] pc : [<c0035810>]    lr : [<c0036214>]    psr: 40000093
>> [   27.163722] sp : df4c1f08  ip : 00000000  fp : df42b400
>> [   27.175185] r10: df470900  r9 : c071c223  r8 : 00000088
>> [   27.180396] r7 : 00000000  r6 : df42b400  r5 : c0755818  r4 : df470900
>> [   27.186905] r3 : 00000004  r2 : 00000080  r1 : c0755818  r0 : df470900
>> [   27.193426] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>> [   27.200797] Control: 18c5387d  Table: 1ef3c04a  DAC: 00000015
>> [   27.206527] Process kworker/u4:1 (pid: 19, stack limit = 0xdf4c0210)
>> [   27.212859] Stack: (0xdf4c1f08 to 0xdf4c2000)
>> [   27.217226] 1f00:                   df4c0000 df42b400 00000001 df42b400 df470918 df42b414
>> [   27.218183] mrf24j40 spi32765.0: SPI transfer timed out
>> [   27.218296] mrf24j40 spi32765.0: SPI write Failed for TX buf
> Did you saw this here?
>
> Smells like a wrong error handling. I don't see in the other message no
> where exactly the NULL pointer dereference is.
>
> I see many workqueue things, the mrf24j40 uses still the xmit_sync
> callback so the tx handling of mac802154 uses a workqueue there but I
> see no issues with some memory leaking in memory handling.
>
> I need more debug output, then I can maybe say what's wrong here.
>
>
> btw: I noticed now, that the isr of mrf24j40 calls spi_sync, which
> scares me a little bit.
>
> ...
>> Also noticed that the extended address reported by iwpan doesn't look right
> yep, that's true I recently sent a patch to this list for fixing this issue.
>
> - Alex

