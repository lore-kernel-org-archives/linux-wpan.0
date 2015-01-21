Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36631 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbbAUPqp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 21 Jan 2015 10:46:45 -0500
Received: by mail-wg0-f43.google.com with SMTP id k14so40501891wgh.2
        for <linux-wpan@vger.kernel.org>; Wed, 21 Jan 2015 07:46:44 -0800 (PST)
Date: Wed, 21 Jan 2015 16:46:37 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Device or resource busy
Message-ID: <20150121154634.GA664@omega>
References: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
 <20150120194407.GB18226@omega>
 <CAAkG1NNuA0vp1A6brVbHw0Co1qL5rAVCPBT=+t+cBZULveBhiw@mail.gmail.com>
 <CAFUtXGw2_+6CCX69RKxv0BueCx5mhddBt3k7yDXzoHcF-r9+Pw@mail.gmail.com>
 <54bf9983.07f4440a.7103.0a2e@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54bf9983.07f4440a.7103.0a2e@mx.google.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Rohit Kulkarni <rmkulkar@gmail.com>
Cc: Maciej Wasilak <wasilak@gmail.com>, linux-wpan@vger.kernel.org

Hi,

On Wed, Jan 21, 2015 at 05:48:36PM +0530, Rohit Kulkarni wrote:
> Hi all,
> 
> I'm now on bluetooth-next and still seeing the problem. So, definitely doesn't look like a raspbian issue.
> 

Can you please check if an ifdown/ifup of your loopback interface works?
Usually name of the interface is "lo". If this works, then we know
it's a 802.15.4 specfic issue and we can do more detailed debugging
steps.

Thanks.

- Alex
