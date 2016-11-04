Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36308 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934360AbcKDNrM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Nov 2016 09:47:12 -0400
Received: by mail-wm0-f51.google.com with SMTP id p190so52189554wmp.1
        for <linux-wpan@vger.kernel.org>; Fri, 04 Nov 2016 06:47:11 -0700 (PDT)
MIME-Version: 1.0
From: Xue Liu <liuxuenetmail@gmail.com>
Date: Fri, 4 Nov 2016 14:19:55 +0100
Message-ID: <CAJuUDwsJvZ0gjcSP02vjAkR4PX6BQq=jTEtMoHtcXheY1kvS7Q@mail.gmail.com>
Subject: How to use wpan-ping
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello everyone,

I would like to use latest wpan-ping in RPi3 4.4.28 with ATUSB stick
(latest firmware). I follow the README.wpan-ping as =E2=80=9C./wpan-ping -d
0x0001=E2=80=9D or "wpan-ping -a 0x0003 -c 5 -s 114", but I got en error
message:

bind: No such device

even with parameter =E2=80=9C-i wpan0=E2=80=9D.

Does wpan-ping require latest kernel like bluetooth-next ? Or did I
miss something ?

Regards,

Xue Liu

--
