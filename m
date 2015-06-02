Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33517 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbbFBHJd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 03:09:33 -0400
Received: by wgez8 with SMTP id z8so132047830wge.0
        for <linux-wpan@vger.kernel.org>; Tue, 02 Jun 2015 00:09:32 -0700 (PDT)
Date: Tue, 2 Jun 2015 09:09:30 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools] info: add frequency to channel listing for
 phy capabilities
Message-ID: <20150602070926.GB1977@omega>
References: <20150601133534.GA14012@probook-6560b>
 <556D2CB8.4070101@gmail.com>
 <20150602060838.GA2744@probook-6560b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150602060838.GA2744@probook-6560b>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Tue, Jun 02, 2015 at 08:08:38AM +0200, Christoffer Holmstedt wrote:
...
> 
> This is for the same reason as above. Alignment in the output, it is a trade
> off between "readability" in two different ways. Alignment in the output or
> printing the full word "Unknown". I will change this to "Unknown" and we can
> change it at a later date if it ever shows up and mess up alignment. In any
> case if "Unknown" shows up the actual frequency should be added instead of
> fixing alignment. ;)
> 

Then maybe some "-" instead "unkown", is this better, or it's too small
then?

- Alex
