Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:18891 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755753AbcHVORf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Aug 2016 10:17:35 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: at86rf233 in Raspberry Pi 3
From: smlng <s@mlng.net>
In-Reply-To: <CAF_bZd2CYeuVpmG_Sb4QKVHtpb7q-WxwhCoXr-4yNoZ1CGvRRg@mail.gmail.com>
Date: Mon, 22 Aug 2016 16:11:25 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <C218BF9B-CADB-4AF6-8ADE-795F51A09859@mlng.net>
References: <CAF_bZd2CYeuVpmG_Sb4QKVHtpb7q-WxwhCoXr-4yNoZ1CGvRRg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Tao Liu <liu3tao@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Tao,

the RIOT-OS Wiki-Guide is rather outdated on this, please have look at =
[1] - this approach works for me and I heard from other, successfully =
using that one too.

Best,
  Sebastian=20

[1]: =
https://github.com/RIOT-Makers/wpan-raspbian/wiki/Create-a-generic-Raspbia=
n-image-with-6LoWPAN-support

> Am 22.08.2016 um 09:50 schrieb Tao Liu <liu3tao@gmail.com>:
>=20
> Dear list,
>=20
> I am trying make at86rf233 radio from openlabs work with Raspberry Pi
> 3. I followed the guide here:
> =
https://github.com/RIOT-OS/RIOT/wiki/How-to-install-6LoWPAN-Linux-Kernel-o=
n-Raspberry-Pi,
> but it seems do not work well in Raspberry Pi 3.
>=20
> So far I can
> - see "at86rf230 spi0.0: Detected at86rf233 chip version 1" in dmesg
> - use iwpan command to list wpan0 interface and set =
pan_id/short_addr/etc.
> - create 6LoWPAN interface
> (http://wpan.cakelab.org/#_setup_a_6lowpan_test_network)
>=20
> But I cannot ping other Raspberry using wpan-ping tool, and pinging
> through 6LoWPAN interface also failed. Can anyone give me some
> pointers about how to setup at86rf233 for Raspberry Pi 3?
>=20
> Thanks in advance,
> Tao
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

