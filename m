Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5310 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbbKYPTA (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 25 Nov 2015 10:19:00 -0500
Message-ID: <1448464729.3531.65.camel@linux.intel.com>
Subject: Re: [PATCH v2 bluetooth-next 0/7] GHC compression detection
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 25 Nov 2015 17:18:49 +0200
In-Reply-To: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
References: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, linux-bluetooth@vger.kernel.org

Hi Stefan,

On Wed, 2015-11-25 at 15:59 +0100, Stefan Schmidt wrote:
> Hello.
> 
> This is a first stab at RFC7400. So far we only hook into the NHC
> framework to
> detect the registered GHC types (extension headers, UDP and ICMPv6).
> This is aligned with how we detect the NHC frames.
> 
> Changes since v1:
>         o Use correct NEXTHDR defines for LOWPAN_NHC()
>         o Split out different extension headers into one module each
>         o Add some help text for configure options
> 
> Changes since RFC:
>         o prefixed new files with nhc_ to stay in line with other nhc
> modules
>         o added linux-bluetooth to CC


looks good and simple so far :)

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka

