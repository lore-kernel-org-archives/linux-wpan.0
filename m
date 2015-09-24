Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:51709 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbbIXSnw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Sep 2015 14:43:52 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next 1/2] ieee802154: remove unnecessary includes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443080231-6416-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 24 Sep 2015 20:43:48 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <A110EBBF-DDF7-4861-A068-04E36CD6704D@holtmann.org>
References: <1443080231-6416-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch removes some unnecessary includes from ieee802154 header,
> which was introduced by commit b609fb54adfa ("ieee802154: add helpers for
> frame control checks").
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> include/linux/ieee802154.h | 3 ---
> 1 file changed, 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

