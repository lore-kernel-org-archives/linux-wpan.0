Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:47725 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485AbbDIR7K (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 13:59:10 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH bluetooth-next v2] mac802154: fix transmission power datatype
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1428567911-1857-1-git-send-email-varkab@cdac.in>
Date: Thu, 9 Apr 2015 10:59:05 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <8F148DD3-10EA-47F9-BC2A-423363E7F3AE@holtmann.org>
References: <1428567911-1857-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Hi Varka,

> Netlink attribute for the power is s8. But for the driver level
> operations we are collection power level value into integer.
> It has to be change to s8 from int.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
> drivers/net/ieee802154/at86rf230.c |    2 +-
> include/net/mac802154.h            |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

