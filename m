Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36663 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936097AbcKLHPR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 12 Nov 2016 02:15:17 -0500
Received: by mail-lf0-f49.google.com with SMTP id t196so26660452lff.3
        for <linux-wpan@vger.kernel.org>; Fri, 11 Nov 2016 23:15:16 -0800 (PST)
Date: Sat, 12 Nov 2016 10:15:12 +0300
From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH iproute2] ip: update link types to show 6lowpan and
 ieee802.15.4 monitor
Message-ID: <20161112101512.79ff3879@samsung9>
In-Reply-To: <1477647723-14641-1-git-send-email-stefan@datenfreihafen.org>
References: <1477647723-14641-1-git-send-email-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: netdev@vger.kernel.org, linux-wpan@vger.kernel.org

On Fri, 28 Oct 2016 11:42:03 +0200
Stefan Schmidt <stefan@datenfreihafen.org> wrote:

> Both types have been missing here and thus ip always showed
> only the numbers.
> 
> Based on a suggestion from Alexander Aring.
> 
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>

Applied 
