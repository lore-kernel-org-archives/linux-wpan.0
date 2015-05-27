Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:52272 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbbE0Lae (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 07:30:34 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv4 bluetooth-next] ieee802154: add set transmit power support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432698054-10050-1-git-send-email-varkab@cdac.in>
Date: Wed, 27 May 2015 13:30:30 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <A1638739-8010-4C7E-996B-E9D98F3ABF36@holtmann.org>
References: <1432698054-10050-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkab@cdac.in>

Hi Varka,

> This patch adds transmission power setting support for IEEE-802.15.4
> devices via nl802154.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
> include/net/cfg802154.h   |    1 +
> net/ieee802154/nl802154.c |   30 ++++++++++++++++++++++++++++++
> net/ieee802154/rdev-ops.h |   12 ++++++++++++
> net/ieee802154/trace.h    |   15 +++++++++++++++
> net/mac802154/cfg.c       |   19 +++++++++++++++++++
> 5 files changed, 77 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

