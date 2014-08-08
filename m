Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:62734 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbaHHImU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Aug 2014 04:42:20 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so6714375pdj.29
        for <linux-wpan@vger.kernel.org>; Fri, 08 Aug 2014 01:42:20 -0700 (PDT)
Message-ID: <53E48D10.3090606@gmail.com>
Date: Fri, 08 Aug 2014 14:10:48 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Regarding dev->addr_len
To: linux-wpan - ML <linux-wpan@vger.kernel.org>
Cc: "alex.aring@gmail.com" <alex.aring@gmail.com>

Hi Alex,

I need some clarification regarding address length for the netdevice.
We are always setting up that to IEEE802154_ADDR_LEN [1].

If i receive a packet (RS: Router Solicitation) with short addressing mode,
it is discarding at higher layers.

If the linux node receives the RS packet from TinyOS node its discarding
at [2] due to address length field. Here [2] we are getting *lladdr* as NULL.


Actually we have to update the dev->addr_len filed as per the packet info it received ..?

How can we make it work..?

  
[1]:http://lxr.free-electrons.com/source/net/mac802154/wpan.c#L375
[2]:http://lxr.free-electrons.com/source/net/ipv6/ndisc.c#L991

-- 
Regards,
Varka Bhadram.

