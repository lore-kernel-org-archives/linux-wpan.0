Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:39254 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976AbbI3LZu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Sep 2015 07:25:50 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH bluetooth-next] ieee802154: change mtu size behaviour
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443436586-6698-1-git-send-email-alex.aring@gmail.com>
Date: Wed, 30 Sep 2015 13:25:21 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <63BB44F8-65F3-432A-B094-ACE127302E50@holtmann.org>
References: <1443436586-6698-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch changes the mtu size of 802.15.4 interfaces. The current
> setting is the meaning of the maximum transport unit with mac header,
> which is 127 bytes according 802.15.4. The linux meaning of the mtu size
> field is the maximum payload of a mac frame. Like in ethernet, which is
> 1500 bytes.
> 
> We have dynamic length of mac frames in 802.15.4, this is why we assume
> the minimum header length which is hard_header_len. This contains fc and
> sequence fields. These can evaluated by driver layer without additional
> checks. We currently don't support to set the FCS from userspace, so we
> need to subtract this from mtu size as well.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/socket.c |  4 ++--
> net/mac802154/iface.c   | 12 +++++++++++-
> net/mac802154/tx.c      | 11 -----------
> 3 files changed, 13 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

