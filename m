Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59116 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbaJFKmI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Oct 2014 06:42:08 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH wpan-next 2/3] ieee802154: reassembly: fix tag byteorder
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1412586052-27299-2-git-send-email-alex.aring@gmail.com>
Date: Mon, 6 Oct 2014 12:42:14 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <3ABB342C-EF7C-48D3-A1B8-957646AC053F@holtmann.org>
References: <1412586052-27299-1-git-send-email-alex.aring@gmail.com> <1412586052-27299-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

> This patch fix byte order handling in reassembly code of 802.15.4
> 6LoWPAN fragmentation handling.
> 
> net/ieee802154/reassembly.c:58:43: warning: restricted __be16 degrades to integer
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Reported-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> net/ieee802154/reassembly.c | 8 +++++---
> net/ieee802154/reassembly.h | 4 ++--
> 2 files changed, 7 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

