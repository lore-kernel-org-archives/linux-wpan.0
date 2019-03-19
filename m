Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:51418 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfCSSIV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Mar 2019 14:08:21 -0400
Date: Tue, 19 Mar 2019 11:08:20 -0700 (PDT)
Message-Id: <20190319.110820.1409898293176657787.davem@davemloft.net>
Subject: Re: pull-request: ieee802154 for net 2019-03-19
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190319162435.16854-1-stefan@datenfreihafen.org>
References: <20190319162435.16854-1-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@datenfreihafen.org
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

From: Stefan Schmidt <stefan@datenfreihafen.org>
Date: Tue, 19 Mar 2019 17:24:35 +0100

> An update from ieee802154 for your *net* tree.
> 
> Kangjie Lu fixed a potential NULL pointer deref in the adf7242 driver and Li
> RongQing make sure we propagate a netlink return code to the caller.
> 
> If there are any problems let me know.

Pulled, thanks Stefan.
