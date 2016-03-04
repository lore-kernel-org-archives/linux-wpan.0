Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from [82.165.8.211] ([82.165.8.211]:45129 "EHLO mail.holtmann.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751415AbcCDRLA (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 4 Mar 2016 12:11:00 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH bluetooth-next 2/2] 6lowpan: debugfs: add missing static
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1457082621-20194-2-git-send-email-aar@pengutronix.de>
Date: Fri, 4 Mar 2016 09:10:53 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <41AFC737-11D2-4C89-A918-13F8AC60C35A@holtmann.org>
References: <1457082621-20194-1-git-send-email-aar@pengutronix.de> <1457082621-20194-2-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch solves the sparse warning:
> 
> net/6lowpan/debugfs.c:164:30: warning: symbol 'lowpan_ctx_pfx_fops' was
> not declared. Should it be static?
> net/6lowpan/debugfs.c:241:30: warning: symbol 'lowpan_context_fops' was
> not declared. Should it be static?
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> net/6lowpan/debugfs.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

