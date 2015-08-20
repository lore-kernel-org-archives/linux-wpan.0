Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:51972 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbbHTSxb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Aug 2015 14:53:31 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] nl802154: stricter input checking for boolean inputs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440065387-7457-1-git-send-email-stefan@osg.samsung.com>
Date: Thu, 20 Aug 2015 11:53:23 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <743F9612-94F8-4952-A5D2-801331F7E625@holtmann.org>
References: <1440065387-7457-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

Hi Stefan,

> So far we handled boolean input by forcing them with !! and assigning
> them into a bool. This allowed userspace to send values > 1 which were
> used as 1. We should be stricter here and return -EINVAL for all but
> 0 or 1.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
> net/ieee802154/nl802154.c | 16 ++++++++++++----
> 1 file changed, 12 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

