Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:16675 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756899AbcHWH3s (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Aug 2016 03:29:48 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: at86rf233 in Raspberry Pi 3
From: smlng <s@mlng.net>
In-Reply-To: <CAF_bZd370Lxvrq1U0uoiCoLdwVJEABt4X3xNXfpOF_RpBeauCg@mail.gmail.com>
Date: Tue, 23 Aug 2016 09:26:23 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <AED49D76-171E-4430-87DC-F4DC52CE909D@mlng.net>
References: <CAF_bZd2CYeuVpmG_Sb4QKVHtpb7q-WxwhCoXr-4yNoZ1CGvRRg@mail.gmail.com> <C218BF9B-CADB-4AF6-8ADE-795F51A09859@mlng.net> <CAF_bZd370Lxvrq1U0uoiCoLdwVJEABt4X3xNXfpOF_RpBeauCg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Tao Liu <liu3tao@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Tao,

you don't have to patch the device directly, I use DT overlays. The =
important steps (different from [2]) in my guide [1] are:

- use latest Raspbian image from [3], see also [4]
- deploy a custom Linux-Kernel using Raspi sources [5], see also [6]
- enable the transceiver using device tree overlays, see [7]

For details and trouble shooting, carefully read my guide top to bottom.=20=


If the at86rf233 doesn't show up, you likely missed to enable the =
overlay in '/boot/config.txt'. But for RPi3 you also have to build a =
custom Linux Kernel, because the default Raspbian-Kernel v4.4 has some =
issues - the device is visible but is not working correctly.

Anyway, I will have to setup some RPi3 for a project in the next days - =
I'll let you know if there is any trouble (and how to solve it).

Best,
  Sebastian

[3]: https://www.raspberrypi.org/downloads/raspbian/
[4]: =
https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-Raspbia=
n-image-with-6LoWPAN-support#2-prepare-raspbian-image
[5]: https://github.com/raspberrypi/linux
[6]: =
https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-Raspbia=
n-image-with-6LoWPAN-support#4-new-linux-kernels-for-the-pi
[7]: =
https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-Raspbia=
n-image-with-6LoWPAN-support#3-enable-support-for-ieee-802154lowpan-device=
s

> Am 22.08.2016 um 23:34 schrieb Tao Liu <liu3tao@gmail.com>:
>=20
> Hi Sebastian,
>=20
> Thanks for the pointers. I followed the link [1] in your email, but
> the at86rf233 does not show in the dmesg, and "iwpan list" command
> outputs "nl802154 not found."
>=20
> In the old (outdated) guide [2], I need to patch the device tree. Do I
> need to do the same with the new guide?
>=20
> [1]: =
https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-Raspbia=
n-image-with-6LoWPAN-support
> [2]: =
https://github.com/RIOT-OS/RIOT/wiki/How-to-install-6LoWPAN-Linux-Kernel-o=
n-Raspberry-Pi
>=20
>=20
> Best Regards,
> Tao
>=20
> On Mon, Aug 22, 2016 at 7:11 AM, smlng <s@mlng.net> wrote:
>> Hi Tao,
>>=20
>> the RIOT-OS Wiki-Guide is rather outdated on this, please have look =
at [1] - this approach works for me and I heard from other, successfully =
using that one too.
>>=20
>> Best,
>>  Sebastian
>>=20
>> [1]: =
https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-Raspbia=
n-image-with-6LoWPAN-support
>>=20
>>> Am 22.08.2016 um 09:50 schrieb Tao Liu <liu3tao@gmail.com>:
>>>=20
>>> Dear list,
>>>=20
>>> I am trying make at86rf233 radio from openlabs work with Raspberry =
Pi
>>> 3. I followed the guide here:
>>> =
https://github.com/RIOT-OS/RIOT/wiki/How-to-install-6LoWPAN-Linux-Kernel-o=
n-Raspberry-Pi,
>>> but it seems do not work well in Raspberry Pi 3.
>>>=20
>>> So far I can
>>> - see "at86rf230 spi0.0: Detected at86rf233 chip version 1" in dmesg
>>> - use iwpan command to list wpan0 interface and set =
pan_id/short_addr/etc.
>>> - create 6LoWPAN interface
>>> (http://wpan.cakelab.org/#_setup_a_6lowpan_test_network)
>>>=20
>>> But I cannot ping other Raspberry using wpan-ping tool, and pinging
>>> through 6LoWPAN interface also failed. Can anyone give me some
>>> pointers about how to setup at86rf233 for Raspberry Pi 3?
>>>=20
>>> Thanks in advance,
>>> Tao
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe =
linux-wpan" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

