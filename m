Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:57853 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbaHKTRR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 Aug 2014 15:17:17 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407756310-26592-5-git-send-email-alex.aring@gmail.com>
Date: Mon, 11 Aug 2014 12:17:50 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <14AF6B17-8BF7-44BB-B455-BA63ED451C01@holtmann.org>
References: <1407756310-26592-1-git-send-email-alex.aring@gmail.com> <1407756310-26592-5-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH 4/4] mac802154: common tx error path
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Varka Bhadram <varkab@cdac.in>

Hi Alex,

> From: Varka Bhadram <varkab@cdac.in>
> 
> This patch introduce the common error path on failure of Tx by
> inserting the label 'err_tx'.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/tx.c | 15 ++++++++-------
> 1 file changed, 8 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

