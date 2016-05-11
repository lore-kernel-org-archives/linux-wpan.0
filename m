Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:46825 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbcEKPNI (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 11 May 2016 11:13:08 -0400
Subject: Re: [PATCH wpan-tools 2/2] phy: add netns support
References: <1462959979-6755-1-git-send-email-aar@pengutronix.de>
 <1462959979-6755-2-git-send-email-aar@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <57334C01.90500@osg.samsung.com>
Date: Wed, 11 May 2016 17:13:05 +0200
MIME-Version: 1.0
In-Reply-To: <1462959979-6755-2-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

Quick tip. If you want to check your code with coverity before putting 
it into master you can push it to the branch coverty_scan on github and 
travis will build and submit it to coverity. I find this handy when 
doing new code to check it before putting it into master. Nothing wrong 
with this code just a tip. :)

On 11/05/16 11:46, Alexander Aring wrote:
> This patch adds netns support, basically most parts are copy&pasted from
> iw tool, same handling just wpan instead wireless.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
>   src/phy.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
>
> diff --git a/src/phy.c b/src/phy.c
> index 816bdd8..887b610 100644
> --- a/src/phy.c
> +++ b/src/phy.c
> @@ -2,6 +2,10 @@
>   #include <errno.h>
>   #include <string.h>
>   #include <stdbool.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
>   
>   #include <netlink/genl/genl.h>
>   #include <netlink/genl/family.h>
> @@ -144,3 +148,65 @@ nla_put_failure:
>   }
>   COMMAND(set, cca_ed_level, "<level>",
>   	NL802154_CMD_SET_CCA_ED_LEVEL, 0, CIB_PHY, handle_cca_ed_level, NULL);
> +
> +#ifndef NETNS_RUN_DIR
> +#define NETNS_RUN_DIR "/var/run/netns"
> +#endif
> +int netns_get_fd(const char *name)
Make this function static?

> +{
> +	char pathbuf[MAXPATHLEN];
> +	const char *path, *ptr;
> +
> +	path = name;
> +	ptr = strchr(name, '/');
> +	if (!ptr) {
> +		snprintf(pathbuf, sizeof(pathbuf), "%s/%s",
> +			NETNS_RUN_DIR, name );
> +		path = pathbuf;
> +	}
> +	return open(path, O_RDONLY);
> +}
> +
> +static int handle_netns(struct nl802154_state *state,
> +			struct nl_cb *cb,
> +			struct nl_msg *msg,
> +			int argc, char **argv,
> +			enum id_input id)
> +{
> +	char *end;
> +	int fd;
> +
> +	if (argc < 1 || !*argv[0])
> +		return 1;
> +
> +	if (argc == 1) {
> +		NLA_PUT_U32(msg, NL802154_ATTR_PID,
> +			    strtoul(argv[0], &end, 10));
> +		if (*end != '\0') {
> +			printf("Invalid parameter: pid(%s)\n", argv[0]);
> +			return 1;
> +		}
> +		return 0;
> +	}
> +
> +	if (argc != 2 || strcmp(argv[0], "name"))
> +		return 1;
> +
> +	if ((fd = netns_get_fd(argv[1])) >= 0) {
> +		NLA_PUT_U32(msg, NL802154_ATTR_NETNS_FD, fd);
> +		return 0;
> +	} else {
> +		printf("Invalid parameter: nsname(%s)\n", argv[0]);
> +	}
> +
> +	return 1;
> +
> + nla_put_failure:
> +	return -ENOBUFS;
> +}
> +COMMAND(set, netns, "{ <pid> | name <nsname> }",
> +	NL802154_CMD_SET_WPAN_PHY_NETNS, 0, CIB_PHY, handle_netns,
> +	"Put this wpan device into a different network namespace:\n"
> +	"    <pid>    - change network namespace by process id\n"
> +	"    <nsname> - change network namespace by name from "NETNS_RUN_DIR"\n"
> +	"               or by absolute path (man ip-netns)\n");

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>

regards
Stefan Schmidt
