Return-Path: <SRS0=bD8h=26=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA311C282DD
	for <linux-wpan@archiver.kernel.org>; Thu,  9 Jan 2020 22:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794212077C
	for <linux-wpan@archiver.kernel.org>; Thu,  9 Jan 2020 22:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpqfjE4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgAIWjI (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:39:08 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41262 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgAIWjH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Jan 2020 17:39:07 -0500
Received: by mail-qk1-f193.google.com with SMTP id x129so145014qke.8
        for <linux-wpan@vger.kernel.org>; Thu, 09 Jan 2020 14:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LRddJvY5VzQLMnJtLXnkfeVCjtHI5Bki13CDEJqiolI=;
        b=YpqfjE4on8M/Zxthc0AfdGfuXo+WrGGpRF4loyZlO0vaYn3zjZlyXLc5BNahivbai2
         AY3++byOXCWm1n5V1xr4SIrMCHG3dh4+I2NghN6VVJ5EVZJiNa/Z30HIBsY+qnNQzhpv
         GOZEZy9x3r021ORcHoJjekwXFFv+wRlPnbjljyQ1VeaGCN7fwmPMEZGOIu2IQsomvgR3
         dYcf5sCkHWrV0rkNoq/W/esaY1HPkkH/Ez6ICxlCGza7OsFzKCfOVqkw92ncVn6nrYvx
         Lo0yANWwpP6inIUYW3o3bhGGy0nHJmPk/AvclY0rOIsF18re4bzCmdjmRgAp6YhMyNvU
         YrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LRddJvY5VzQLMnJtLXnkfeVCjtHI5Bki13CDEJqiolI=;
        b=Ju4j9t5C+Z2SElpNiWmYVCSgUuI+uMLUaIyQ08LiuoLVexZCKMIFVPI8r0dUUL909N
         cZa4ilXwWSyCXGppd/j8Rg9LGOOnGwgwPZEEJlAngtoiCtSYv3Wf1tfNc7gX96dIDIe5
         NA3nFjjtcitWnPDaBcykxpKh+3IHXnmCAuB5kch4cz9uzA+7Xx6dNDgyjcJWC9kPJjXK
         nz0z8AZGm6kJJKiT5+7FNAXUHMpsH92zP7ExEGg+1hhoBC/7PfjG17Sn3HjTwJTHUml+
         SQ3PLBO3DkVUn2RFku0EUDFldvfTcF86DiekeZ7Qfrxifv28vrRLq1b8IXQxoWSVjAxu
         JMJQ==
X-Gm-Message-State: APjAAAXaEPi8YTNf8/hSX5mgm0+hAg2BcAZLWRkAcH5cl+ON4Y1CJR/X
        FTF6xcLd8zY5q4luYMxGahdm3XmF
X-Google-Smtp-Source: APXvYqwhqQBhfJAurA6PC4VGraYA7eyOgJZo3QOQ/LW2ow6PcqYr0QTj3yRqT0bSCzmkenjeR9DMDA==
X-Received: by 2002:a37:658f:: with SMTP id z137mr218631qkb.234.1578609547198;
        Thu, 09 Jan 2020 14:39:07 -0800 (PST)
Received: from ryzen (104-195-198-158.cpe.teksavvy.com. [104.195.198.158])
        by smtp.gmail.com with ESMTPSA id n19sm3694585qkn.52.2020.01.09.14.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 14:39:06 -0800 (PST)
Date:   Thu, 9 Jan 2020 17:38:59 -0500
From:   Alexander Aring <alex.aring@gmail.com>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan@vger.kernel.org
Subject: Re: [PATCH rpld 0/6] Mixed bag of rpld patches
Message-ID: <20200109223859.kfveuy6tmwtzc5mm@ryzen>
References: <20190918195819.7492-1-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190918195819.7492-1-stefan@datenfreihafen.org>
User-Agent: NeoMutt/20180716
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Stefan,

On Wed, Sep 18, 2019 at 09:58:13PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> This series does really not have any theme, besides me starting
> to look into rpld and playing around with it.
> 
> I had to fix meson for my lua detection and make sure the ifdef
> for SCOPE_ID is honoured. After getting it all building locally
> I added Travis support and submitted builds to Coverity.
> Afterwards I did a quick run through the reports from address
> sanitizer and coverity scan.
> 
> Not sure if you would prefer review for rpld as patches here on
> the list or as pull requests on github. Up to you.
> 
> Stefan Schmidt (6):
>   build: test various names for our lua dependency
>   send: make sure we check on scope id usage
>   ci: travis: initial setup for CI testing with Travis
>   config : fix leaks on error paths
>   socket: make sure we close our socket if setsockopt() fails
>   send: ensure we free the buffer after sending the message

I tested the patch series and so far it still compiles on my machine.

Reviewed-by: Alexander Aring <alex.aring@gmail.com>

on all patches.

- Alex
