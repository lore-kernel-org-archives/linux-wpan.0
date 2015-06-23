Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:42453 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbbFWKUG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Jun 2015 06:20:06 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] mac802154: use WARN_ON() macro
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1435039863-27225-1-git-send-email-varkab@cdac.in>
Date: Tue, 23 Jun 2015 12:19:53 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <11C6ECC9-9EA3-414A-A081-C39689D6C207@holtmann.org>
References: <1435039863-27225-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Hi Varka,

> This patch will generate the warning if the required driver ops
> were not defined. Also it removes unnecessary debug message.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
> net/mac802154/main.c |    6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

