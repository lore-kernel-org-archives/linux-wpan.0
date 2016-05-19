Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:42246 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527AbcESSbZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 19 May 2016 14:31:25 -0400
Date: Thu, 19 May 2016 11:31:23 -0700 (PDT)
Message-Id: <20160519.113123.1347754718914705188.davem@davemloft.net>
Subject: Re: [PATCH 1/1] net: ieee802154/adf7242: syntax error ifdef DEBUG
From: David Miller <davem@davemloft.net>
In-Reply-To: <1463522320-10964-1-git-send-email-xypron.glpk@gmx.de>
References: <1463522320-10964-1-git-send-email-xypron.glpk@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: xypron.glpk@gmx.de
Cc: michael.hennerich@analog.com, aar@pengutronix.de, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Date: Tue, 17 May 2016 23:58:40 +0200

> If DEBUG is defined, a superfluous closing brace
> is introduced.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied.
