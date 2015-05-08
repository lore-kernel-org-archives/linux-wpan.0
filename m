Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from sssup.it ([193.205.80.95]:42494 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407AbbEHM1z (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 8 May 2015 08:27:55 -0400
Message-ID: <554CABCA.7080909@sssup.it>
Date: Fri, 08 May 2015 14:27:54 +0200
From: Matteo Petracca <matteo.petracca@sssup.it>
MIME-Version: 1.0
Subject: Re: Error in including IEEE802154.h
References: <554B97A8.2040802@sssup.it> <20150508115030.GA15416@omega>
In-Reply-To: <20150508115030.GA15416@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,
the program that I am trying to compile is the test1.c
in the lowpan-tools.

#include <linux/sockios.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>

#include "ieee802154.h"

int main(int argc, char **argv) {
     int ret;
     char *iface = argv[1] ?: "wpan0";

     char buf[] = {0x40, 0x00, 0x56};
     int sd = socket(PF_IEEE802154, SOCK_RAW, 0);
     if (sd < 0) {
         perror("socket");
         return 1;
     }

     ret = setsockopt(sd, SOL_SOCKET, SO_BINDTODEVICE, iface, 
strlen(iface) + 1);
     if (ret < 0)
         perror("setsockopt: BINDTODEVICE");

     ret = send(sd, buf, sizeof(buf), 0);
     if (ret < 0)
         perror("send");

     ret = recv(sd, buf, sizeof(buf), 0);
     if (ret < 0)
         perror("recv");

     ret = shutdown(sd, SHUT_RDWR);
     if (ret < 0)
         perror("shutdown");

     ret = close(sd);
     if (ret < 0)
         perror("close");

     return 0;

}

It worked in kernel 3.8.13 on BBB, now I get the error

test1.c:35:24: fatal error: ieee802154.h: No such file or directory

in kernel 4.0.1.

Matteo

On 08/05/2015 13:50, Alexander Aring wrote:
> Hi,
>
> On Thu, May 07, 2015 at 06:49:44PM +0200, Matteo Petracca wrote:
>> Dear all,
>> I gave a program in kernel 3.8.17 in which I successfully include
>> ieee802154.h by simply witing:
>>
>> #include <ieee802154.h>
>>
>> In my BeagleBone now I have just upgraded the kernel to 4.0.1,
>> and compiling the same code I get:
>>
>> fatal error: ieee802154.h: No such file or directory
>>
>> Any hint?
>>
> no, I suppose that this header is some of the old netlink interface, but
> I can't be sure here. I can't be sure because I don't know what was the
> functionality/why you need  that in your application.
>
>
> In short:
>
> We don't deliever any headers to uapi for userspace. If you need headers
> for userspace<->kernelspace communication you need to grab them on your
> own out of your current kernel source tree. What I mean is that we
> didn't change any in our uapi headers which are deliviered by
> kernel-headers because we don't have any headers which laying inside
> "include/uapi" tree right now.
>
> - Alex

