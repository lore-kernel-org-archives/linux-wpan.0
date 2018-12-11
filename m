Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:39688 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeLKTFN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Dec 2018 14:05:13 -0500
Date: Tue, 11 Dec 2018 11:05:09 -0800 (PST)
Message-Id: <20181211.110509.486045790718608390.davem@davemloft.net>
Subject: Re: pull-request: ieee802154 for net 2018-12-11
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181211085302.27306-1-stefan@datenfreihafen.org>
References: <20181211085302.27306-1-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@datenfreihafen.org
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

From: Stefan Schmidt <stefan@datenfreihafen.org>
Date: Tue, 11 Dec 2018 09:53:02 +0100

> An update from ieee802154 for your *net* tree.
> 
> Just two more fixes for ieee802154 dribver before the final 4.20 release.
> Alexander Aring fixes a problem in the nested parsing code of the
> hwsim driver interface.
> A fix for a potential overflow in the ca8210 driver by Yue Habing.
> 
> If there are any problems with taking these two before the final 4.20 let me
> know.

Pulled, thanks Stefan.
