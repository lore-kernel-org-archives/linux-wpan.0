Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:46218 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeENS3F (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 14 May 2018 14:29:05 -0400
MIME-Version: 1.0
In-Reply-To: <20180514154002.ehab2ss25a45l5p6@x220t>
References: <CAKyrCQUJWq8aOMskFkr3FJF3Kgt2mKz5tsMCYH7PKqNawybJnA@mail.gmail.com>
 <20180514154002.ehab2ss25a45l5p6@x220t>
From: Roman Makhov <roman.makhov@gmail.com>
Date: Mon, 14 May 2018 21:29:03 +0300
Message-ID: <CAKyrCQWbFuRuFmn42Oo9qcOmHxxvsF=8Zg2a6d6aGaY034xHXA@mail.gmail.com>
Subject: Re: Kernel panic on kernel-3.10.0-693.21.1.el7 in ndisc.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org

Hi Alexander,

Thank you for the answer.
Unfortunately CentOS goes with these dinosaurs.
So we will try to debug the problem in the current one and try to
reproduce on the latest kernel.

Thanks,
Roman.

2018-05-14 18:40 GMT+03:00 Alexander Aring <aring@mojatatu.com>:
> Hi,
>
> On Sun, May 13, 2018 at 02:35:07PM +0300, Roman Makhov wrote:
>> Hello,
>>
>> We have a problem with Kernel panic after upgrade from CentOS 7.3
>> (kernel-3.10.0-514.el7) to CentOS 7.4 (kernel-3.10.0-693.21.1.el7).
>> It occurs when we have the incoming traffic from other nodes and we
>> are performing the re-configuration of IPv6 interfaces.
>>
>> It is high-availability system without 802.15.4 support.
>>
>> The log of crash:
>> =========================================================
>> #10 [ffff88043fc03cf0] async_page_fault at ffffffff816b7798
>>     [exception RIP: ndisc_send_rs+238]
>>     RIP: ffffffff8166575e  RSP: ffff88043fc03da8  RFLAGS: 00010202
>>     RAX: 0000000000000002  RBX: ffff88042caa9000  RCX: 0000000000000001
>>     RDX: 0000000000000000  RSI: 0000000000000200  RDI: ffffffff816534f7
>>     RBP: ffff88043fc03dd0   R8: 0000000000000000   R9: ffffffff81e9f1c0
>>     R10: 0000000000000002  R11: ffff88043fc03da8  R12: 0000000000000008
>>     R13: 0000000000000006  R14: ffff88043fc03de0  R15: ffffffff81772410
>>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>> #11 [ffff88043fc03da0] ndisc_send_rs at ffffffff81665704
>> =========================================================
>>
>> I see that crash points on ndisc.h, it is ndisc_ops_opt_addr_space()
>> in function:
>> =========================================================
>> crash> kmem ffffffff8166575e
>> ffffffff8166575e (T) ndisc_send_rs+238
>> /usr/src/debug/kernel-3.10.0-693.21.1.el7/linux-3.10.0-693.21.1.el7.x86_64/include/net/ndisc.h:
>> 251
>>
>>       PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
>> ffffea0000059940   1665000                0        0  1 1fffff00000400 reserved
>> crash>
>> =========================================================
>>
>> I checked the difference between 514 and 693 kernels is in the patch
>> https://patchwork.kernel.org/patch/9179229/ .
>>
>> Any suggesions about what I am doing wrong are welcome.
>>
>
> Me as original author of this patch,
>
> I cannot help you with such a dinosaurs kernel. Please try it with the
> latest one and check if the problem still exists.
>
> - Alex
