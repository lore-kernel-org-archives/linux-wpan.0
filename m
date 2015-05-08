Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:64404 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbbEHMQN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 08:16:13 -0400
Message-ID: <554CA909.5030201@xsilon.com>
Date: Fri, 08 May 2015 13:16:09 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: HW Address Filter
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hi Alex,

In my driver I have a set_hw_addr_filt ieee802154_ops but it doesn't seem to get called.  I setup the interface using

iwpan phy phy0 interface add wpan0 type node 00:03:9a:00:00:00:01:2c
iwpan dev wpan0 set pan_id 0x0777
iwpan dev wpan0 set short_addr 0x012c
iwpan phy phy0 set channel 0 11
ip link add link wpan0 name lowpan0 type lowpan
ifconfig lowpan0 up
ifconfig wpan0 up


I thought the first 3 lines would trigger the setting up of the HW address filter or do I need to do something else?

- Martin.

