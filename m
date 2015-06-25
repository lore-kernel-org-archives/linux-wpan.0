Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36749 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbbFYQwh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Jun 2015 12:52:37 -0400
Received: by lbbpo10 with SMTP id po10so49295326lbb.3
        for <linux-wpan@vger.kernel.org>; Thu, 25 Jun 2015 09:52:35 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 25 Jun 2015 18:52:35 +0200
Message-ID: <CAPpUg6NdCLUL=Ht5pDF-panVzDsPY1mKXt0T4xPzxoyVB7X91Q@mail.gmail.com>
Subject: ping6 doesn't use at86rf230 driver
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

Following is how I configure the network:
modprobe at86rf230
iwpan phy wpan-phy0 interface add wpan0 type node
iwpan dev wpan0 set pan_id 0xbeef
ip link set wpan0 up
ip link add link wpan0 name lowpan0 type lowpan
ip link set lowpan0 up

Then I try to ping6 my second board with:
ping6 -I lowpan0 fe80::a8af:ac69:e53e:c7f1

I'm observing no changes over the SPI between my board and the
at86rf230. But if I change the channel with:
iwpan phy wpan-phy0 set channel 0 0
I observe the changes over SPI.

So I'm wondering why ping6 doesn't seem to use the transceiver?
Where am I wrong?

Regards,

-- 
Baptiste
