Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:47942 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbbFDK3Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 06:29:16 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2 bluetooth-next] nl802154: export supported commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433403456-25913-1-git-send-email-varkab@cdac.in>
Date: Thu, 4 Jun 2015 12:29:13 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <1F7E2598-90CE-415B-B5D9-81A426F567E0@holtmann.org>
References: <1433403456-25913-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkab@cdac.in>

Hi Varka,

> This patch will export the supported commands by the devices
> to the userspace. This will be useful to check if HardMAC
> drivers can support a specific command or not.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> Acked-by: Alexander Aring <alex.aring@gmail.com>
> ---
> changes since v1:
> 	o fix the commit message
> 	o update the policy in nl802154.c
> 
> include/net/nl802154.h    |    2 ++
> net/ieee802154/nl802154.c |   40 ++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 42 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

