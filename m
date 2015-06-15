Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36781 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbbFOTHk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Jun 2015 15:07:40 -0400
Received: by wigg3 with SMTP id g3so87556998wig.1
        for <linux-wpan@vger.kernel.org>; Mon, 15 Jun 2015 12:07:39 -0700 (PDT)
Date: Mon, 15 Jun 2015 21:07:33 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 1/2] at86rf230: fix phy settings while
 sleeping
Message-ID: <20150615190732.GA1841@omega>
References: <1434395026-4638-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1434395026-4638-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

On Mon, Jun 15, 2015 at 09:03:45PM +0200, Alexander Aring wrote:
> While in sleep state and we can't access the at86rf2xx registers. This
> can currently occur on phy settings only. All other driver callbacks are
> accessible between the start <-> stop period which puts the phy into
> another state than sleep.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>

drop this, I will send a v2.

- Alex
