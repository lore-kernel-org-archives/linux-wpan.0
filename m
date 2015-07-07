Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:53426 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756788AbbGGMPz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Jul 2015 08:15:55 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH bluetooth-next 2/2] mac802154: fix ieee802154_rx handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1436246443-8243-2-git-send-email-varkabhadram@gmail.com>
Date: Tue, 7 Jul 2015 14:15:51 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <E2606742-E344-49EB-8E3B-EC6BAFF42A36@holtmann.org>
References: <1436246443-8243-1-git-send-email-varkabhadram@gmail.com> <1436246443-8243-2-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com

Hi Varka,

> Instead of passing ieee802154_hw pointer to ieee802154_rx,
> we can directly pass the ieee802154_local pointer.
> 
> Signed-off-by: Varka Bhadram <varkabhadram@gmail.com>
> ---
> net/mac802154/ieee802154_i.h |    2 +-
> net/mac802154/main.c         |    2 +-
> net/mac802154/rx.c           |    3 +--
> 3 files changed, 3 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

