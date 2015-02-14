Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36075 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbbBNVe1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Feb 2015 16:34:27 -0500
Date: Sat, 14 Feb 2015 22:34:22 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] at86rf230: assign wait_for_completion_timeout to
 appropriately typed var
Message-ID: <20150214213422.GB4035@omega>
References: <1423385700-11125-1-git-send-email-hofrat@osadl.org>
 <20150208093428.GA10594@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150208093428.GA10594@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, marcel@holtmann.org

On Sun, Feb 08, 2015 at 10:34:34AM +0100, Alexander Aring wrote:
> On Sun, Feb 08, 2015 at 03:55:00AM -0500, Nicholas Mc Guire wrote:
> > return type of wait_for_completion_timeout is unsigned long not int.
> > As rc is used here only for wait_for_completion_timeout the type is simply
> > changed to unsigned long.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> 
> Acked-by: Alexander Aring <alex.aring@gmail.com>
> 
> Marcel, can you please queue this for bluetooth-next. Should be able to
> apply against bluetooth-next. Thanks.
> 

Marcel, ping.

- Alex
