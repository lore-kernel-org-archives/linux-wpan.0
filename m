Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59366 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759019AbbFBRWl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 13:22:41 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv3 bluetooth-next] mac802154: add trace functionality for driver ops
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433148746-24727-1-git-send-email-varkab@cdac.in>
Date: Tue, 2 Jun 2015 19:22:37 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <9489A94E-11AA-4815-92DA-05516C831F2E@holtmann.org>
References: <1433148746-24727-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Hi Varka,

> This patch adds trace events for driver operations.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
> net/mac802154/Makefile     |    4 +-
> net/mac802154/driver-ops.h |   92 ++++++++++++---
> net/mac802154/trace.c      |    9 ++
> net/mac802154/trace.h      |  272 ++++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 362 insertions(+), 15 deletions(-)
> create mode 100644 net/mac802154/trace.c
> create mode 100644 net/mac802154/trace.h

patch has been applied to bluetooth-next tree.

Regards

Marcel

