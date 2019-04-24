Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it1-f182.google.com ([209.85.166.182]:40076 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfDXEMA (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Apr 2019 00:12:00 -0400
Received: by mail-it1-f182.google.com with SMTP id k64so3946337itb.5
        for <linux-wpan@vger.kernel.org>; Tue, 23 Apr 2019 21:12:00 -0700 (PDT)
Received: from ?IPv6:2601:245:c501:a88f:c4db:2aa4:2b61:fbbf? ([2601:245:c501:a88f:c4db:2aa4:2b61:fbbf])
        by smtp.gmail.com with ESMTPSA id 64sm8220364ite.42.2019.04.23.21.11.58
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 21:11:58 -0700 (PDT)
From: Aditya Nath <nath46950@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: wpan-ping not working for an initial setup of Openlabs 802.15.4
 modules connected to rapsberry pi.
Message-Id: <114FA400-E2AA-441C-8691-B3D69E4C0414@gmail.com>
References: <6BFF517D-8A33-4817-A251-BE649C27BE3D@gmail.com>
Date: Wed, 24 Apr 2019 00:11:57 -0400
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I=E2=80=99m trying to get basic ping working between the two devices and =
from each of them it says host unreachable.
My setup includes 2 raspberry pi 3b+ model and each of them attached to =
2 Openlabs 802.15.4 module.

I ran the following commands on each of them seperately:

ip link set wpan0 down
iwpan phy0 set channel 0 15
iwpan dev wpan0 set pan_id 0x1111
iwpan dev wpan0 set short_addr 0x0001
ip link set wpan0 up

wpan-ping -d 0x0002

The only difference between the two pi was that I changed the short_addr =
for the other pi to 0x0002.

The ping command used was:

wpan-ping -a 0x0001 -s 5 -c 5

I understand you must tbe very busy, but I would really appreciate if =
you can support with some answers. There is very little thorough =
documentation on the web elsehwere, and that is why I have to turn to =
thtis mailing list for answes.

Thanks,
Aditya Nath=
