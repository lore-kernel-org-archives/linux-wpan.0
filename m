Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:53764 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758459AbaKUQFf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 21 Nov 2014 11:05:35 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so5153802pab.40
        for <linux-wpan@vger.kernel.org>; Fri, 21 Nov 2014 08:05:35 -0800 (PST)
Message-ID: <546F62C1.6010500@gmail.com>
Date: Fri, 21 Nov 2014 21:35:21 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Unused function mac802154_header_parse()
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan - ML <linux-wpan@vger.kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>

Hi,

There are two header_ops operations defined for mac802154 at [1]. One is for creating header another for parsing.

Creation of mac802154_header_create() happening at [2] by using dev_hard_header(), but i did not find dev_parse_header()
for header parse by mac802154_header_parse().

Am i missing anything.?



[1]:http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac802154/iface.c#n368  
[2]:http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/ieee802154/dgram.c#n274

-- 
Thanks and Regards,
Varka Bhadram.

