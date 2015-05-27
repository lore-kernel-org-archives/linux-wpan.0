Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:44114 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbbE0RcJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 13:32:09 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next 2/2] nl802154: add support to set cca ed level
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432726930-20126-3-git-send-email-alex.aring@gmail.com>
Date: Wed, 27 May 2015 19:32:05 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <030B4BC8-F524-4FD5-BED8-83064E8697DE@holtmann.org>
References: <1432726930-20126-1-git-send-email-alex.aring@gmail.com> <1432726930-20126-3-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch adds support for setting the current cca ed level value over
> nl802154.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> include/net/cfg802154.h   |  1 +
> net/ieee802154/nl802154.c | 30 ++++++++++++++++++++++++++++++
> net/ieee802154/rdev-ops.h | 11 +++++++++++
> net/ieee802154/trace.h    | 15 +++++++++++++++
> net/mac802154/cfg.c       | 19 +++++++++++++++++++
> 5 files changed, 76 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

