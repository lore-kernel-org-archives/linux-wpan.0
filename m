Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:57566 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732391AbeHFW3V (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Aug 2018 18:29:21 -0400
Date: Mon, 06 Aug 2018 13:18:37 -0700 (PDT)
Message-Id: <20180806.131837.154627724686386668.davem@davemloft.net>
Subject: Re: pull-request: ieee802154-next 2018-08-06
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180806193850.31949-1-stefan@datenfreihafen.org>
References: <20180806193850.31949-1-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@datenfreihafen.org
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

From: Stefan Schmidt <stefan@datenfreihafen.org>
Date: Mon,  6 Aug 2018 21:38:50 +0200

> An update from ieee802154 for *net-next*
> 
> Romuald added a socket option to get the LQI value of the received datagram.
> Alexander added a new hardware simulation driver modelled after hwsim of the
> wireless people. It allows runtime configuration for new nodes and edges over a
> netlink interface (a config utlity is making its way into wpan-tools).
> We also have three fixes in here. One from Colin which is more of a cleanup and
> two from Alex fixing tailroom and single frame space problems.
> I would normally put the last two into my fixes tree, but given we are already
> in -rc8 I simply put them here and added a cc: stable to them.
> 
> Please pull, or let me know if there are any problems.

Pulled, thank you.
