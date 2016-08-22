Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-yb0-f179.google.com ([209.85.213.179]:35325 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754737AbcHVWCo (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Aug 2016 18:02:44 -0400
Received: by mail-yb0-f179.google.com with SMTP id z10so44488550ybh.2
        for <linux-wpan@vger.kernel.org>; Mon, 22 Aug 2016 15:02:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C218BF9B-CADB-4AF6-8ADE-795F51A09859@mlng.net>
References: <CAF_bZd2CYeuVpmG_Sb4QKVHtpb7q-WxwhCoXr-4yNoZ1CGvRRg@mail.gmail.com>
 <C218BF9B-CADB-4AF6-8ADE-795F51A09859@mlng.net>
From: Tao Liu <liu3tao@gmail.com>
Date: Mon, 22 Aug 2016 14:34:28 -0700
Message-ID: <CAF_bZd370Lxvrq1U0uoiCoLdwVJEABt4X3xNXfpOF_RpBeauCg@mail.gmail.com>
Subject: Re: at86rf233 in Raspberry Pi 3
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: smlng <s@mlng.net>
Cc: linux-wpan@vger.kernel.org

Hi Sebastian,

Thanks for the pointers. I followed the link [1] in your email, but
the at86rf233 does not show in the dmesg, and "iwpan list" command
outputs "nl802154 not found."

In the old (outdated) guide [2], I need to patch the device tree. Do I
need to do the same with the new guide?

[1]: https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-Raspbian-image-with-6LoWPAN-support
[2]: https://github.com/RIOT-OS/RIOT/wiki/How-to-install-6LoWPAN-Linux-Kernel-on-Raspberry-Pi


Best Regards,
Tao

On Mon, Aug 22, 2016 at 7:11 AM, smlng <s@mlng.net> wrote:
> Hi Tao,
>
> the RIOT-OS Wiki-Guide is rather outdated on this, please have look at [1] - this approach works for me and I heard from other, successfully using that one too.
>
> Best,
>   Sebastian
>
> [1]: https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-Raspbian-image-with-6LoWPAN-support
>
>> Am 22.08.2016 um 09:50 schrieb Tao Liu <liu3tao@gmail.com>:
>>
>> Dear list,
>>
>> I am trying make at86rf233 radio from openlabs work with Raspberry Pi
>> 3. I followed the guide here:
>> https://github.com/RIOT-OS/RIOT/wiki/How-to-install-6LoWPAN-Linux-Kernel-on-Raspberry-Pi,
>> but it seems do not work well in Raspberry Pi 3.
>>
>> So far I can
>> - see "at86rf230 spi0.0: Detected at86rf233 chip version 1" in dmesg
>> - use iwpan command to list wpan0 interface and set pan_id/short_addr/etc.
>> - create 6LoWPAN interface
>> (http://wpan.cakelab.org/#_setup_a_6lowpan_test_network)
>>
>> But I cannot ping other Raspberry using wpan-ping tool, and pinging
>> through 6LoWPAN interface also failed. Can anyone give me some
>> pointers about how to setup at86rf233 for Raspberry Pi 3?
>>
>> Thanks in advance,
>> Tao
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
