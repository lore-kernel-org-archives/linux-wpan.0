Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:58157 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590AbaHKTRe (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 Aug 2014 15:17:34 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407756310-26592-3-git-send-email-alex.aring@gmail.com>
Date: Mon, 11 Aug 2014 12:18:04 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <7A093622-CCE7-42B3-97A9-26851E637674@holtmann.org>
References: <1407756310-26592-1-git-send-email-alex.aring@gmail.com> <1407756310-26592-3-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH 2/4] mac802154: common error path
To: Alexander Aring <alex.aring@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Varka Bhadram <varkab@cdac.in>

Hi Alex,

> From: Varka Bhadram <varkab@cdac.in>
> 
> By introducing label fail, making the common error path for
> mac802154_llsec_decrypt() and packet type default case.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/wpan.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

