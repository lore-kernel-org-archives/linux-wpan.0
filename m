Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:54168 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaJAElt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Oct 2014 00:41:49 -0400
Date: Wed, 01 Oct 2014 00:41:45 -0400 (EDT)
Message-Id: <20141001.004145.666953186448073320.davem@davemloft.net>
Subject: Re: [PATCH 1/1 linux-next] ieee802154: add __init to
 lowpan_frags_sysctl_register
From: David Miller <davem@davemloft.net>
In-Reply-To: <1016857334.83918.1412138209231.open-xchange@webmail.nmp.skynet.be>
References: <1412109249-7432-1-git-send-email-fabf@skynet.be>
	<20141001002459.GA1007@omega>
	<1016857334.83918.1412138209231.open-xchange@webmail.nmp.skynet.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: fabf@skynet.be
Cc: alex.aring@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org

From: Fabian Frederick <fabf@skynet.be>
Date: Wed, 1 Oct 2014 06:36:49 +0200 (CEST)

>     I didn't see _ns_ . I'll send the right fix based on wpan-next.

You'll have to send it to me, because I applied your patch already
to net-next.
