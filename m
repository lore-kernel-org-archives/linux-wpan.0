Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:52304 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732191AbeHNTr0 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 14 Aug 2018 15:47:26 -0400
Date: Tue, 14 Aug 2018 09:59:28 -0700 (PDT)
Message-Id: <20180814.095928.105413574175329813.davem@davemloft.net>
Subject: Re: [PATCH net-next] ieee802154: hwsim: using right kind of
 iteration
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180812202456.22317-1-aring@mojatatu.com>
References: <20180812202456.22317-1-aring@mojatatu.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: aring@mojatatu.com
Cc: netdev@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@mojatatu.com, stefan@datenfreihafen.org

From: Alexander Aring <aring@mojatatu.com>
Date: Sun, 12 Aug 2018 16:24:56 -0400

> This patch fixes the error path to unsubscribe all other phy's from
> current phy. The actually code using a wrong kind of list iteration may
> copied from the case to unsubscribe the current phy from all other
> phy's.
> 
> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> Signed-off-by: Alexander Aring <aring@mojatatu.com>

I'll apply this directly, thanks.
