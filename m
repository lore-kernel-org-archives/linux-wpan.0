Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:48212 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbaLSLCm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Dec 2014 06:02:42 -0500
Received: by mail-wg0-f42.google.com with SMTP id k14so993967wgh.29
        for <linux-wpan@vger.kernel.org>; Fri, 19 Dec 2014 03:02:41 -0800 (PST)
Date: Fri, 19 Dec 2014 12:02:35 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next RESEND] at86rf230: cleanup check on trac
 status
Message-ID: <20141219110231.GA15986@omega>
References: <1418981810-17663-1-git-send-email-alex.aring@gmail.com>
 <6AC2F7D7-DA76-4D7C-B49C-485E3F25414F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6AC2F7D7-DA76-4D7C-B49C-485E3F25414F@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Fri, Dec 19, 2014 at 11:57:24AM +0100, Marcel Holtmann wrote:
> Hi Alex,
> 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>
> > ---
> > drivers/net/ieee802154/at86rf230.c | 8 +++-----
> > 1 file changed, 3 insertions(+), 5 deletions(-)
> 
> patch has been applied to bluetooth-next tree.
> 
> I would however prefer that even these small patches get a commit message explaining why that is correct and now was wrong before. Does not have to be anything big, but at least some sort of commit message body clearly explaining it would be helpful.
> 

Okay, thanks.

I need to admit that writing commit messages in some cases is more work than
to write the programming changes.

Nevertheless I will try to change that.

- Alex
