Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35592 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbcHVHue (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Aug 2016 03:50:34 -0400
Received: by mail-yw0-f171.google.com with SMTP id j12so46715061ywb.2
        for <linux-wpan@vger.kernel.org>; Mon, 22 Aug 2016 00:50:34 -0700 (PDT)
MIME-Version: 1.0
From: Tao Liu <liu3tao@gmail.com>
Date: Mon, 22 Aug 2016 00:50:12 -0700
Message-ID: <CAF_bZd2CYeuVpmG_Sb4QKVHtpb7q-WxwhCoXr-4yNoZ1CGvRRg@mail.gmail.com>
Subject: at86rf233 in Raspberry Pi 3
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Dear list,

I am trying make at86rf233 radio from openlabs work with Raspberry Pi
3. I followed the guide here:
https://github.com/RIOT-OS/RIOT/wiki/How-to-install-6LoWPAN-Linux-Kernel-on-Raspberry-Pi,
but it seems do not work well in Raspberry Pi 3.

So far I can
- see "at86rf230 spi0.0: Detected at86rf233 chip version 1" in dmesg
- use iwpan command to list wpan0 interface and set pan_id/short_addr/etc.
- create 6LoWPAN interface
(http://wpan.cakelab.org/#_setup_a_6lowpan_test_network)

But I cannot ping other Raspberry using wpan-ping tool, and pinging
through 6LoWPAN interface also failed. Can anyone give me some
pointers about how to setup at86rf233 for Raspberry Pi 3?

Thanks in advance,
Tao
