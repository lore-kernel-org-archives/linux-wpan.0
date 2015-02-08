Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:64135 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbbBHJeo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 8 Feb 2015 04:34:44 -0500
Date: Sun, 8 Feb 2015 10:34:35 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] at86rf230: assign wait_for_completion_timeout to
 appropriately typed var
Message-ID: <20150208093428.GA10594@omega>
References: <1423385700-11125-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1423385700-11125-1-git-send-email-hofrat@osadl.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, marcel@holtmann.org

On Sun, Feb 08, 2015 at 03:55:00AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int.
> As rc is used here only for wait_for_completion_timeout the type is simply
> changed to unsigned long.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Acked-by: Alexander Aring <alex.aring@gmail.com>

Marcel, can you please queue this for bluetooth-next. Should be able to
apply against bluetooth-next. Thanks.

- Alex
