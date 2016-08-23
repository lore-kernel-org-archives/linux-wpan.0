Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-yb0-f175.google.com ([209.85.213.175]:35019 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbcHWRt5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Aug 2016 13:49:57 -0400
Received: by mail-yb0-f175.google.com with SMTP id z10so53135020ybh.2
        for <linux-wpan@vger.kernel.org>; Tue, 23 Aug 2016 10:49:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AED49D76-171E-4430-87DC-F4DC52CE909D@mlng.net>
References: <CAF_bZd2CYeuVpmG_Sb4QKVHtpb7q-WxwhCoXr-4yNoZ1CGvRRg@mail.gmail.com>
 <C218BF9B-CADB-4AF6-8ADE-795F51A09859@mlng.net> <CAF_bZd370Lxvrq1U0uoiCoLdwVJEABt4X3xNXfpOF_RpBeauCg@mail.gmail.com>
 <AED49D76-171E-4430-87DC-F4DC52CE909D@mlng.net>
From: Tao Liu <liu3tao@gmail.com>
Date: Tue, 23 Aug 2016 10:49:35 -0700
Message-ID: <CAF_bZd1hfSChrFt+QKwWohaNeJ8HeHB-x3ubinZiDFt8fEYTpw@mail.gmail.com>
Subject: Re: at86rf233 in Raspberry Pi 3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: smlng <s@mlng.net>
Cc: linux-wpan@vger.kernel.org

Hi Sebastian,

I am able to ping my node now -- thanks a lot for your help!

It turns out I didn't enable the transceiver in /boot/config.txt. I
jumped directly to building the new kernel, and skipped the part 3 of
your guide.

Thanks again for providing the wonderful guide!

Best,
Tao





On Tue, Aug 23, 2016 at 12:26 AM, smlng <s@mlng.net> wrote:
> Hi Tao,
>
> you don't have to patch the device directly, I use DT overlays. The impor=
tant steps (different from [2]) in my guide [1] are:
>
> - use latest Raspbian image from [3], see also [4]
> - deploy a custom Linux-Kernel using Raspi sources [5], see also [6]
> - enable the transceiver using device tree overlays, see [7]
>
> For details and trouble shooting, carefully read my guide top to bottom.
>
> If the at86rf233 doesn't show up, you likely missed to enable the overlay=
 in '/boot/config.txt'. But for RPi3 you also have to build a custom Linux =
Kernel, because the default Raspbian-Kernel v4.4 has some issues - the devi=
ce is visible but is not working correctly.
>
> Anyway, I will have to setup some RPi3 for a project in the next days - I=
'll let you know if there is any trouble (and how to solve it).
>
> Best,
>   Sebastian
>
> [3]: https://www.raspberrypi.org/downloads/raspbian/
> [4]: https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-R=
aspbian-image-with-6LoWPAN-support#2-prepare-raspbian-image
> [5]: https://github.com/raspberrypi/linux
> [6]: https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-R=
aspbian-image-with-6LoWPAN-support#4-new-linux-kernels-for-the-pi
> [7]: https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-R=
aspbian-image-with-6LoWPAN-support#3-enable-support-for-ieee-802154lowpan-d=
evices
>
>> Am 22.08.2016 um 23:34 schrieb Tao Liu <liu3tao@gmail.com>:
>>
>> Hi Sebastian,
>>
>> Thanks for the pointers. I followed the link [1] in your email, but
>> the at86rf233 does not show in the dmesg, and "iwpan list" command
>> outputs "nl802154 not found."
>>
>> In the old (outdated) guide [2], I need to patch the device tree. Do I
>> need to do the same with the new guide?
>>
>> [1]: https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-=
Raspbian-image-with-6LoWPAN-support
>> [2]: https://github.com/RIOT-OS/RIOT/wiki/How-to-install-6LoWPAN-Linux-K=
ernel-on-Raspberry-Pi
>>
>>
>> Best Regards,
>> Tao
>>
>> On Mon, Aug 22, 2016 at 7:11 AM, smlng <s@mlng.net> wrote:
>>> Hi Tao,
>>>
>>> the RIOT-OS Wiki-Guide is rather outdated on this, please have look at =
[1] - this approach works for me and I heard from other, successfully using=
 that one too.
>>>
>>> Best,
>>>  Sebastian
>>>
>>> [1]: https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic=
-Raspbian-image-with-6LoWPAN-support
>>>
>>>> Am 22.08.2016 um 09:50 schrieb Tao Liu <liu3tao@gmail.com>:
>>>>
>>>> Dear list,
>>>>
>>>> I am trying make at86rf233 radio from openlabs work with Raspberry Pi
>>>> 3. I followed the guide here:
>>>> https://github.com/RIOT-OS/RIOT/wiki/How-to-install-6LoWPAN-Linux-Kern=
el-on-Raspberry-Pi,
>>>> but it seems do not work well in Raspberry Pi 3.
>>>>
>>>> So far I can
>>>> - see "at86rf230 spi0.0: Detected at86rf233 chip version 1" in dmesg
>>>> - use iwpan command to list wpan0 interface and set pan_id/short_addr/=
etc.
>>>> - create 6LoWPAN interface
>>>> (http://wpan.cakelab.org/#_setup_a_6lowpan_test_network)
>>>>
>>>> But I cannot ping other Raspberry using wpan-ping tool, and pinging
>>>> through 6LoWPAN interface also failed. Can anyone give me some
>>>> pointers about how to setup at86rf233 for Raspberry Pi 3?
>>>>
>>>> Thanks in advance,
>>>> Tao
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-wpan" =
in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
