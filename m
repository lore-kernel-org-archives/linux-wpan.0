Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35381 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbbJAK2Z (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Oct 2015 06:28:25 -0400
Received: by wicge5 with SMTP id ge5so22716169wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 01 Oct 2015 03:28:24 -0700 (PDT)
Date: Thu, 1 Oct 2015 12:28:17 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Linux-Bluetoothnext: Ping6 execution for virtual Phy : System
 freezes
Message-ID: <20151001102815.GA2034@omega>
References: <51C7DE700DAED543997957503C74C84501074D1F@POCITMSEXMB05.LntUniverse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51C7DE700DAED543997957503C74C84501074D1F@POCITMSEXMB05.LntUniverse.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Anoop Kant <Anoop.Kant@LNTTECHSERVICES.COM>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "kantanoop@yahoo.com" <kantanoop@yahoo.com>

On Thu, Oct 01, 2015 at 10:15:40AM +0000, Anoop Kant wrote:
> Thanks Alex for the information!!
> 
> I executed the steps as provided in previous mail. My system gets freeze after enabling lowpan0 interface.
> i.e. after executing command  // ip link set lowpan0 up //
> 

mhhh, kernel freeze should never happen and with the below details I
can't say why you get a freeze.

> Every time, I have to reboot my system to get it up back.
> 
> From Syslog, I see below : Am I missing something ? Any clue on probable reason of this issue ?
> 
> 
> Oct  1 14:57:49 yocto-HP-ProBook-4420s AptDaemon: INFO: Quitting due to inactivity Oct  1 14:57:49 yocto-HP-ProBook-4420s AptDaemon: INFO: Quitting was requested Oct  1 15:08:36 yocto-HP-ProBook-4420s kernel: [ 1137.587417] ieee802154fakelb ieee802154fakelb: added ieee802154 hardware
> Oct  1 15:08:36 yocto-HP-ProBook-4420s NetworkManager[1373]:    SCPlugin-Ifupdown: devices added (path: /sys/devices/platform/ieee802154fakelb/ieee802154/phy1/net/wpan1, iface: wpan1)
> Oct  1 15:08:36 yocto-HP-ProBook-4420s NetworkManager[1373]:    SCPlugin-Ifupdown: device added (path: /sys/devices/platform/ieee802154fakelb/ieee802154/phy1/net/wpan1, iface: wpan1): no ifupdown configuration found.
> Oct  1 15:08:36 yocto-HP-ProBook-4420s NetworkManager[1373]:    SCPlugin-Ifupdown: devices added (path: /sys/devices/platform/ieee802154fakelb/ieee802154/phy0/net/wpan0, iface: wpan0)
> 
> 
> Oct  1 15:08:36 yocto-HP-ProBook-4420s NetworkManager[1373]:    SCPlugin-Ifupdown: device added (path: /sys/devices/platform/ieee802154fakelb/ieee802154/phy0/net/wpan0, iface: wpan0): no ifupdown configuration found. =====> Erros in logs
> 
> 
> Oct  1 15:10:06 yocto-HP-ProBook-4420s NetworkManager[1373]:    SCPlugin-Ifupdown: devices added (path: /sys/devices/virtual/net/lowpan0, iface: lowpan0)
> Oct  1 15:10:06 yocto-HP-ProBook-4420s NetworkManager[1373]:    SCPlugin-Ifupdown: device added (path: /sys/devices/virtual/net/lowpan0, iface: lowpan0): no ifupdown configuration found.
> Oct  1 15:12:21 yocto-HP-ProBook-4420s kernel: imklog 5.8.6, log source = /proc/kmsg started.
> 

Can you please try to turn others networking managers for configurations
off? I will put a test with fakelb and NetworkManager on my todo list
and will check if I get a kernel freeze too.

- Alex
