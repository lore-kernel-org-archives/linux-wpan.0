Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:59674 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfD2WVN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Apr 2019 18:21:13 -0400
Date: Mon, 29 Apr 2019 18:21:09 -0400 (EDT)
Message-Id: <20190429.182109.2278488103649846421.davem@davemloft.net>
Subject: Re: pull-request: ieee802154 for net 2019-04-25
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190425160311.19767-1-stefan@datenfreihafen.org>
References: <20190425160311.19767-1-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@datenfreihafen.org
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

From: Stefan Schmidt <stefan@datenfreihafen.org>
Date: Thu, 25 Apr 2019 18:03:11 +0200

> An update from ieee802154 for your *net* tree.
> 
> Another fix from Kangjie Lu to ensure better checking regmap updates in the
> mcr20a driver. Nothing else I have pending for the final release.
> 
> If there are any problems let me know.

Pulled, thanks Stefan.

> During the preparation of this pull request a workflow question on
> my side came up and wonder if you (or some subsystem maintainer
> sending you pull requests) does have a comment on this. The
> ieee802154 subsystem has a low activity in the number of patches
> coming through it. I still wanted to pull from your net tree
> regularly to test if changes have implications to it. During this
> pulls I often end up with merge of the remote tracking branch. Which
> in the end could mean that I would have something like 3-4 merge
> commits in my tree with only one actual patch I want to send over to
> you. Feels and looks kind of silly to be honest.
> 
> How do other handle this? Just merge once every rc? Merge just
> before sending a pull request? Never merge, wait for Dave to pull
> and merge and do a pull of his tree directly afterwards?

I would say never pull from the net tree until right after I pull your
tree and thus you can do a clean fast-forward merge.

If you want to test, right before you send me a pull request do a test
pull into a local throw-away branch.

Otherwise I'll handle conflicts and merge issues.

Thanks.
