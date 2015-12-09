Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33780 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbbLIWSP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Dec 2015 17:18:15 -0500
Received: by mail-wm0-f42.google.com with SMTP id c201so6370726wme.0
        for <linux-wpan@vger.kernel.org>; Wed, 09 Dec 2015 14:18:14 -0800 (PST)
Date: Wed, 9 Dec 2015 23:18:08 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth] mac802154: tx: fix synced xmit deadlock
Message-ID: <20151209221807.GA16100@omega>
References: <1449699331-17563-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1449699331-17563-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Michael Hennerich <michael.hennerich@analog.com>

Hi Marcel,

On Wed, Dec 09, 2015 at 11:15:31PM +0100, Alexander Aring wrote:
> This patch reverts 6001d52 ("mac802154: tx: don't allow if down while
> sync tx"). This has side effects with stop callback which flush the
> transmit workqueue. The stop callback will wait until the workqueue is
> flushed and holding the rtnl lock. That means it can happen that the stop
> callback waits forever because it try to lock the rtnl mutex which is
> already hold by stop callback.
> 

wrong patch here, I will send a v2 which also remove the ASSERT_RTNL
while synced xmit driver callback.

- Alex

