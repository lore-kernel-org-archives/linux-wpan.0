Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:35268 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbbGMO7W (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Jul 2015 10:59:22 -0400
Received: by lahh5 with SMTP id h5so18085397lah.2
        for <linux-wpan@vger.kernel.org>; Mon, 13 Jul 2015 07:59:20 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 13 Jul 2015 16:59:20 +0200
Message-ID: <CAPpUg6NHtUaebTAgQjypqVndvTfpjU+bmnmrcSiTN60pkhJv+g@mail.gmail.com>
Subject: ping6 -> lowpan0 -> wpan0. Ping6 doesn't succeed to send messages
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

Here is how I set the network:
modprobe at86rf230
iwpan dev wpan0 set pan_id 0xbeef
ip link set wpan0 up
ip link add link wpan0 name lowpan0 type lowpan
ip link set lowpan0 up

Then I try to do:
ping6 -I lowpan0 fe80::a8af:ac69:e53e:c7f1

Nothing is sent. (I checked by sniffing the SPI pins). No errors from
ping6 or other layers in the network stack.

root@OpenWrt:/# ifconfig
lowpan0   Link encap:UNSPEC  HWaddr
05-38-09-06-90-E0-5E-3E-00-00-00-00-00-00-00-00
          inet6 addr: fe80::738:906:90e0:5e3e/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1280  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

wpan0     Link encap:UNSPEC  HWaddr
05-38-09-06-90-E0-5E-3E-00-00-00-00-00-00-00-00
          UP BROADCAST RUNNING NOARP  MTU:127  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:300
          RX bytes:0 (0.0 B)  TX bytes:75 (75.0 B)

(TX bytes:75 (75.0 B), seems to be sent when you up lowpan0 ?)


Is my settings right? What should I check to make sure the data goes
from each layer of the network stack?

Regards,

-- 
Baptiste
