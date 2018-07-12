Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:55952 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeGLH1i (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 12 Jul 2018 03:27:38 -0400
Date: Thu, 12 Jul 2018 00:19:21 -0700 (PDT)
Message-Id: <20180712.001921.2154013288150485193.davem@davemloft.net>
Subject: Re: pull-request: ieee802154 for net 2018-07-11
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180711152653.28579-1-stefan@datenfreihafen.org>
References: <20180711152653.28579-1-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@datenfreihafen.org
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

From: Stefan Schmidt <stefan@datenfreihafen.org>
Date: Wed, 11 Jul 2018 11:26:53 -0400

> An update from ieee802154 for your *net* tree.
> 
> Build system fix for a missing include from Arnd Bergmann.
> Setting the IFLA_LINK for the lowpan parent from Lubomir Rintel.
> Fixes for some RX corner cases in adf7242 driver by Michael Hennerich.
> And some small patches to cleanup our BUG_ON vs WARN_ON usage.

Pulled, thanks.
