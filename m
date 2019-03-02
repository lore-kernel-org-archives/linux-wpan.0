Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:60836 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCBBDT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Mar 2019 20:03:19 -0500
Date: Fri, 01 Mar 2019 17:03:18 -0800 (PST)
Message-Id: <20190301.170318.1704538618070251369.davem@davemloft.net>
Subject: Re: [PATCH 0/2] doc: net: ieee802154: move from plain text to rst
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190227195914.4594-1-stefan@datenfreihafen.org>
References: <20190227195914.4594-1-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@datenfreihafen.org
Cc: corbet@lwn.net, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-wpan@vger.kernel.org

From: Stefan Schmidt <stefan@datenfreihafen.org>
Date: Wed, 27 Feb 2019 20:59:12 +0100

> The ieee802154 subsystem doc was still in plain text. With the networking book
> taking shape I thought it was time to do the first step and move it over to rst.
> This really is only the minimal conversion. I need to take some time to update
> and extend the docs.
> 
> The patches are based on net-next, but they only touch the networking book so I
> would not expect and trouble. From what I have seen they would go through
> Jonathan's tree after being acked by Dave? If you want this patches against a
> different tree let me know.

Series applied, thanks Stefan.
